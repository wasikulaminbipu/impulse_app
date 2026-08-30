---
name: searchengine-expert
description: Use when designing, building, optimizing, or debugging search features, search engines, query processing pipelines, index structures, indexing pipelines, ranking algorithms, filtering, facets, vector/hybrid search, full-text search engines (SQLite FTS5, Drift, Elasticsearch, OpenSearch, Meilisearch, Typesense, Algolia, Lucene), or search UI/UX (instant search, autocomplete, fuzzy matching, highlighting, debouncing, pagination).
---

# Search Engine Expert Skill & Best Practices

This guide provides comprehensive architectural patterns, performance optimization strategies, indexing techniques, query execution standards, and UI/UX conventions for building state-of-the-art search engines and search experiences across mobile apps (Flutter/Dart), local SQLite/Drift databases, and distributed search services.

---

## 1. Search Architecture & Core Foundations

Every high-performance search system consists of 4 decoupled core stages:

```text
[ Query Input ] -> [ 1. Query Processing Pipeline ] -> [ 2. Index & Storage Layer ]
                                                               |
[ Search UI/UX ] <- [ 4. Results & Highlighting ]   <- [ 3. Ranking & Scoring ]
```

### Stage 1: Query Processing Pipeline
1. **Normalization & Cleaning**: Lowercasing, accent stripping (diacritics removal), punctuation handling, unicode normalization (NFC/NFD).
2. **Tokenization**: Whitespace, n-gram (trigram/bigram), edge n-gram, or language-aware stemming/lemmatization (e.g. Porter Stemmer, Unicode 61).
3. **Stopword Filtering**: Removing low-signal words (optional based on intent; retain for exact phrase matching).
4. **Fuzzy & Synonyms Expansion**: Soundex/Metaphone, Levenshtein distance matching, thesaurus/synonym expansion, prefix expansion (`query*`).
5. **Token Boosting & Scoping**: Field-specific weights (e.g. `sku^10.0 title^5.0 category^3.0 description^1.0`).

### Stage 2: Indexing & Storage Engine
* **Inverted Index**: Core structure mapping tokens $\to$ document IDs with term frequencies and positions.
* **SQLite / Drift FTS5**: Local full-text search with BM25 scoring, prefix queries, match info, trigram tokenizers, and porter stemmers.
* **Vector Index (ANN)**: HNSW, IVF-Flat, Cosine/Dot Product similarity for semantic search.
* **Hybrid Search**: Reciprocal Rank Fusion (RRF) combining sparse BM25 keyword search with dense vector search.

### Stage 3: Ranking & Scoring Strategies
* **BM25 (Best Matching 25)**: Standard probabilistic relevance framework balancing Term Frequency ($TF$) and Inverse Document Frequency ($IDF$) with length normalization ($k_1$, $b$).
* **Business Recency & Popularity Boosting**: Blending relevance score with business metrics (sales, page views, updated timestamp decay):
  $$\text{Score}_{\text{final}} = \text{Score}_{\text{BM25}} \times (1 + w_{\text{pop}} \cdot \text{Popularity}) \times e^{-\lambda \cdot \Delta t}$$
* **Attribute Priority**: Tiered match precedence (Exact SKU/ID > Title Exact > Title Prefix > Category > Description).

### Stage 4: Results & Visual Highlighting
* Token-aware snippet extraction, match boundary calculation, dynamic term highlighting, exact result counts, and paginated response payloads.

---

## 2. SQLite & Drift FTS5 Implementation (Flutter/Mobile)

For local client-side search in Flutter using Drift / SQLite:

### 2.1 Schema Design & Auto-Sync Triggers (`fts5` Virtual Table)
Always separate your normalized domain tables from the FTS5 virtual table. Use SQLite triggers or DAO layer synchronization to keep the search index strictly up to date. Multi-column FTS indexes should include indexed attributes like `category` or `sku`. Use `trigram` tokenizer when prefix/substring search across code/SKU tokens is required.

```dart
// Drift FTS5 Table Definition
import 'package:drift/drift.dart';

@TableIndex(name: 'idx_products_name', columns: {#name})
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  DateTimeColumn get updatedAt => dateTime()();
}

// Virtual FTS5 Table for Fast Full-Text Search
class ProductsFts extends Table implements Fts5Table {
  IntColumn get rowid => integer().named('rowid')();
  TextColumn get sku => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();

  @override
  String get tableName => 'products_fts';
}
```

#### SQLite Triggers for Automatic FTS Index Sync
```sql
-- Trigger on INSERT
CREATE TRIGGER IF NOT EXISTS trg_products_ai AFTER INSERT ON products BEGIN
  INSERT INTO products_fts(rowid, sku, name, description, category)
  VALUES (new.id, new.sku, new.name, COALESCE(new.description, ''), new.category);
END;

-- Trigger on DELETE
CREATE TRIGGER IF NOT EXISTS trg_products_ad AFTER DELETE ON products BEGIN
  INSERT INTO products_fts(products_fts, rowid, sku, name, description, category)
  VALUES('delete', old.id, old.sku, old.name, COALESCE(old.description, ''), old.category);
END;

-- Trigger on UPDATE
CREATE TRIGGER IF NOT EXISTS trg_products_au AFTER UPDATE ON products BEGIN
  INSERT INTO products_fts(products_fts, rowid, sku, name, description, category)
  VALUES('delete', old.id, old.sku, old.name, COALESCE(old.description, ''), old.category);
  INSERT INTO products_fts(rowid, sku, name, description, category)
  VALUES (new.id, new.sku, new.name, COALESCE(new.description, ''), new.category);
END;
```

### 2.2 Robust FTS5 Query Sanitization & Prefix Matcher
Convert raw query input safely to prevent FTS5 syntax errors (unmatched quotes, boolean operators, special characters) while supporting multi-term AND prefix matching across indexed fields:

```dart
String sanitizeAndBuildFts5Query(String rawInput) {
  // Strip special FTS syntax characters: double quotes, asterisks, colons, parentheses, OR/AND keywords
  final cleaned = rawInput.trim().replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ' ');
  final tokens = cleaned.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
  if (tokens.isEmpty) return '';

  // Escape each token in quotes with prefix matching: "token1"* AND "token2"*
  return tokens.map((token) => '"$token"*').join(' AND ');
}
```

### 2.3 BM25 Ranking, Column Weighting & Drift DAO Execution
In SQLite FTS5, `bm25()` returns negative/lower scores for better relevance matches. Provide explicit column weights corresponding to field order in the FTS table (e.g. `sku: 10.0`, `name: 5.0`, `description: 1.0`, `category: 3.0`):

```sql
-- Raw SQL Query executed via Drift Custom Select
SELECT 
  p.*, 
  bm25(products_fts, 10.0, 5.0, 1.0, 3.0) AS relevance_score,
  snippet(products_fts, 1, '<mark>', '</mark>', '...', 10) AS highlighted_name
FROM products_fts fts
JOIN products p ON p.id = fts.rowid
WHERE products_fts MATCH :ftsQuery
ORDER BY relevance_score ASC
LIMIT :limit OFFSET :offset;
```

---

## 3. High-Performance Search UI/UX & State Management (Flutter)

### 3.1 Cancelable Debounced Riverpod Search Provider
Always debounce search input (200–300ms) to prevent unnecessary query execution and race conditions when users type rapidly.

```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Search Query Input State
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

// Async Search Results Provider with Debounce & Cancellation Support
final searchResultsProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) return const [];

  // 1. Debounce delay to avoid triggering requests on every keystroke
  bool cancelled = false;
  ref.onDispose(() => cancelled = true);

  await Future.delayed(const Duration(milliseconds: 250));
  if (cancelled) throw Exception('Query superceded');

  // 2. Execute DB search call
  final repository = ref.watch(productRepositoryProvider);
  return repository.searchProducts(query);
});
```

### 3.2 Instant Clear, Loading States & Dynamic Text Highlighting
1. **Clear Icon**: Display clear (`X`) button only when text is non-empty to reset query instantly.
2. **Subtle Loading**: Display inline dynamic spinner while debouncing or executing DB calls.
3. **Zero State vs Empty Result**: Distinguish between initial state ("Type to search...") and zero search results ("No products matching 'xyz'").
4. **Rich Text Term Highlighting Widget**:

```dart
class SearchTermHighlighter extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle normalStyle;
  final TextStyle highlightStyle;

  const SearchTermHighlighter({
    super.key,
    required this.text,
    required this.query,
    required this.normalStyle,
    required this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (query.trim().isEmpty) return Text(text, style: normalStyle);

    // Escape query special characters for regex matching
    final cleanQuery = RegExp.escape(query.trim().replaceAll(RegExp(r'\s+'), ' '));
    final tokens = cleanQuery.split(' ').where((t) => t.isNotEmpty);
    if (tokens.isEmpty) return Text(text, style: normalStyle);

    final pattern = tokens.join('|');
    final regex = RegExp(pattern, caseSensitive: false);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) return Text(text, style: normalStyle);

    final spans = <TextSpan>[];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start), style: normalStyle));
      }
      spans.add(TextSpan(text: text.substring(match.start, match.end), style: highlightStyle));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd), style: normalStyle));
    }

    return RichText(text: TextSpan(children: spans));
  }
}
```

---

## 4. Search Analytics, Telemetry & Zero-Result Tracking

Tracking search metrics enables catalog optimization, identifying missing inventory demand, and measuring search conversion efficiency.

### 4.1 Key Search Metrics to Track
1. **Zero-Result Rate (ZRR)**: % of executed searches that yield zero results ($\text{ZRR} = \frac{\text{Zero Result Queries}}{\text{Total Queries}}$). High ZRR indicates missing products or poor synonym coverage.
2. **Click-Through Rate (CTR)**: % of searches resulting in a user tapping a result item.
3. **Mean Reciprocal Rank (MRR)**: Evaluates position quality of clicked search results ($\text{MRR} = \frac{1}{|Q|} \sum_{i=1}^{|Q|} \frac{1}{\text{rank}_i}$).
4. **Latency (P50/P95/P99)**: Execution latency of query processing and database execution.

### 4.2 Search Telemetry Logger Pattern (Dart)

```dart
class SearchAnalyticsEvent {
  final String query;
  final int resultCount;
  final int executionTimeMs;
  final DateTime timestamp;
  final String? clickedEntityId;
  final int? clickedRank;

  SearchAnalyticsEvent({
    required this.query,
    required this.resultCount,
    required this.executionTimeMs,
    required this.timestamp,
    this.clickedEntityId,
    this.clickedRank,
  });

  Map<String, dynamic> toJson() => {
        'query': query,
        'result_count': resultCount,
        'execution_time_ms': executionTimeMs,
        'timestamp': timestamp.toIso8601String(),
        'clicked_entity_id': clickedEntityId,
        'clicked_rank': clickedRank,
        'is_zero_result': resultCount == 0,
      };
}

class SearchAnalyticsTracker {
  static void logSearch({
    required String query,
    required int resultCount,
    required int executionTimeMs,
  }) {
    if (query.trim().isEmpty) return;
    
    final event = SearchAnalyticsEvent(
      query: query.trim().toLowerCase(),
      resultCount: resultCount,
      executionTimeMs: executionTimeMs,
      timestamp: DateTime.now(),
    );

    // Send to local logging buffer or remote telemetry service
    if (event.resultCount == 0) {
      // High-priority alert/event for zero-result monitoring
      _logZeroResultQuery(event);
    }
  }

  static void _logZeroResultQuery(SearchAnalyticsEvent event) {
    // Log to analytics backend to surface missing user query trends
  }
}
```

---

## 5. Advanced Client-Side Algorithms: Autocomplete & Synonym Expansion

### 5.1 In-Memory Trie Data Structure for Instant Autocomplete
For zero-latency prefix suggestions on mobile devices (e.g. search suggestions, search history, tag autocomplete):

```dart
class TrieNode {
  final Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  int frequency = 0;
}

class AutocompleteTrie {
  final TrieNode root = TrieNode();

  void insert(String word) {
    var current = root;
    for (final char in word.toLowerCase().codeUnits) {
      final key = String.fromCharCode(char);
      current = current.children.putIfAbsent(key, () => TrieNode());
    }
    current.isEndOfWord = true;
    current.frequency++;
  }

  List<String> getSuggestions(String prefix, {int maxResults = 5}) {
    var current = root;
    for (final char in prefix.toLowerCase().codeUnits) {
      final key = String.fromCharCode(char);
      if (!current.children.containsKey(key)) return [];
      current = current.children[key]!;
    }

    final results = <MapEntry<String, int>>[];
    _dfs(current, prefix.toLowerCase(), results);
    results.sort((a, b) => b.value.compareTo(a.value)); // Sort by frequency descending

    return results.take(maxResults).map((e) => e.key).toList();
  }

  void _dfs(TrieNode node, String currentPrefix, List<MapEntry<String, int>> results) {
    if (node.isEndOfWord) {
      results.add(MapEntry(currentPrefix, node.frequency));
    }
    node.children.forEach((char, childNode) {
      _dfs(childNode, currentPrefix + char, results);
    });
  }
}
```

---

## 6. Advanced Search Techniques: Caching, History & Pagination

### 6.1 LRU Query Cache Manager
Cache frequent search queries in memory to eliminate redundant database queries:

```dart
import 'dart:collection';

class SearchQueryCache<T> {
  final int capacity;
  final LinkedHashMap<String, List<T>> _cache = LinkedHashMap();

  SearchQueryCache({this.capacity = 50});

  List<T>? get(String query) {
    final key = query.trim().toLowerCase();
    if (!_cache.containsKey(key)) return null;

    // Move key to end (most recently used)
    final val = _cache.remove(key)!;
    _cache[key] = val;
    return val;
  }

  void put(String query, List<T> results) {
    final key = query.trim().toLowerCase();
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else if (_cache.length >= capacity) {
      _cache.remove(_cache.keys.first); // Evict least recently used
    }
    _cache[key] = results;
  }

  void clear() => _cache.clear();
}
```

### 6.2 Search History Tracker (Recent Searches)
Store and manage recent user search queries cleanly:

```dart
class SearchHistoryManager {
  final int maxHistory;
  final List<String> _history = [];

  SearchHistoryManager({this.maxHistory = 10});

  List<String> get history => List.unmodifiable(_history);

  void addQuery(String query) {
    final cleaned = query.trim();
    if (cleaned.isEmpty) return;

    _history.removeWhere((item) => item.toLowerCase() == cleaned.toLowerCase());
    _history.insert(0, cleaned);

    if (_history.length > maxHistory) {
      _history.removeLast();
    }
  }

  void removeQuery(String query) {
    _history.removeWhere((item) => item.toLowerCase() == query.trim().toLowerCase());
  }

  void clearHistory() => _history.clear();
}
```

### 6.3 Hybrid Search & Reciprocal Rank Fusion (RRF)
When combining Full-Text Keyword Search (BM25) and Semantic Vector Search (Embeddings):

1. Retrieve Top $K$ results from Sparse Keyword Search (Rank $R_{\text{sparse}}$).
2. Retrieve Top $K$ results from Dense Vector Search (Rank $R_{\text{dense}}$).
3. Calculate fused score for each document $d$:
   $$RRF\_Score(d) = \frac{1}{60 + R_{\text{sparse}}(d)} + \frac{1}{60 + R_{\text{dense}}(d)}$$
4. Sort candidate documents by $RRF\_Score$ descending.

```dart
List<T> reciprocalRankFusion<T>({
  required List<T> sparseResults,
  required List<T> denseResults,
  required String Function(T) getId,
  int k = 60,
}) {
  final scores = <String, double>{};
  final itemMap = <String, T>{};

  for (int i = 0; i < sparseResults.length; i++) {
    final item = sparseResults[i];
    final id = getId(item);
    itemMap[id] = item;
    scores[id] = (scores[id] ?? 0.0) + (1.0 / (k + (i + 1)));
  }

  for (int i = 0; i < denseResults.length; i++) {
    final item = denseResults[i];
    final id = getId(item);
    itemMap[id] = item;
    scores[id] = (scores[id] ?? 0.0) + (1.0 / (k + (i + 1)));
  }

  final sortedIds = scores.keys.toList()
    ..sort((a, b) => scores[b]!.compareTo(scores[a]!));

  return sortedIds.map((id) => itemMap[id]!).toList();
}
```

### 6.4 Faceted Search & Dynamic Aggregation Pipeline
Calculate dynamic category/brand counts for active search results:

```dart
class FacetCount {
  final String value;
  final int count;

  const FacetCount(this.value, this.count);
}

Map<String, List<FacetCount>> calculateFacets<T>({
  required List<T> items,
  required Map<String, String Function(T)> facetExtractors,
}) {
  final result = <String, List<FacetCount>>{};

  for (final entry in facetExtractors.entries) {
    final facetName = entry.key;
    final extractor = entry.value;
    final counts = <String, int>{};

    for (final item in items) {
      final val = extractor(item);
      if (val.isNotEmpty) {
        counts[val] = (counts[val] ?? 0) + 1;
      }
    }

    final facetList = counts.entries
        .map((e) => FacetCount(e.key, e.value))
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));

    result[facetName] = facetList;
  }

  return result;
}
```

---

## 7. Performance Optimization & Production Checklist

1. **DB Indexing**: Ensure columns used in `WHERE`, `ORDER BY`, and foreign keys (`category_id`, `updated_at`, `rowid`) are properly indexed.
2. **FTS Table Maintenance**: Run `INSERT INTO products_fts(products_fts) VALUES('optimize');` periodically (e.g. post-bulk sync or database migration) to merge SQLite FTS index b-tree segments.
3. **Memory & Pagination Safety**: Always paginate search results (`LIMIT / OFFSET` or cursor). Never map >100 un-paginated UI items directly into widget trees. Use LRU Cache (`SearchQueryCache`) for zero-latency UI back-navigation.
4. **Isolate Offloading**: Perform heavy token processing, trie lookups, Levenshtein edit distance calculations, or JSON transformations on background Dart Isolates via `Isolate.run()` or `compute()`.
5. **Analytics & Zero-Result Telemetry**: Monitor Zero-Result Rate (ZRR) and search latency to continuously optimize synonyms and indexing coverage.
6. **Static Analysis & Testing**:
   * Run `flutter analyze` after modifying search providers, FTS schema, or database queries.
   * Write unit tests for query sanitization, BM25 weight bindings, search providers, trie autocomplete, Levenshtein distance, LRU query cache, search history, zero-result telemetry, and UI text highlighters.
