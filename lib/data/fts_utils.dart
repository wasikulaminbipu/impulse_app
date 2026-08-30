import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

/// Pharmaceutical, veterinary, generic, dosage form, and symptom search synonym dictionary.
const Map<String, List<String>> _searchSynonyms = {
  // Antibiotics & Antimicrobials
  'amox': ['amoxicillin', 'amoxycillin', 'অ্যামোক্সিসিলিন'],
  'amoxicillin': ['amox', 'amoxycillin', 'antibiotic'],
  'cipro': ['ciprofloxacin', 'সিপ্রোফ্লক্সাসিন'],
  'ciprofloxacin': ['cipro', 'antibiotic'],
  'doxy': ['doxycycline', 'ডক্সিসাইক্লিন'],
  'doxycycline': ['doxy', 'antibiotic'],
  'oxy': ['oxytetracycline', 'অক্সিটেট্রাসাইক্লিন'],
  'oxytetracycline': ['oxy', 'tetracycline', 'antibiotic'],
  'enro': ['enrofloxacin', 'এনরোফ্লক্সাসিন'],
  'enrofloxacin': ['enro', 'antibiotic'],
  'tylosin': ['tylo', 'tylosin tartrate', 'টাইলোসিন'],
  'tylo': ['tylosin'],
  'neomycin': ['neo', 'neomycin sulfate'],
  'gentamicin': ['genta', 'gentamycin'],
  'antibiotic': [
    'antimicrobial',
    'bactericidal',
    'amoxicillin',
    'ciprofloxacin',
    'enrofloxacin',
  ],

  // Anthelmintics & Dewormers
  'anthelmintic': [
    'dewormer',
    'wormer',
    'albendazole',
    'levamisole',
    'ivermectin',
  ],
  'dewormer': [
    'anthelmintic',
    'albendazole',
    'wormer',
    'ivermectin',
    'ডিল ওয়ার্মার',
  ],
  'wormer': ['anthelmintic', 'dewormer', 'albendazole'],
  'albendazole': ['dewormer', 'anthelmintic', 'alben'],
  'ivermectin': ['iver', 'dewormer', 'ectoparasiticide'],
  'levamisole': ['leva', 'dewormer', 'anthelmintic'],

  // Vitamins, Minerals & Additives
  'vit': ['vitamin', 'ভিটামিন'],
  'vitamin': ['vit', 'multivitamin'],
  'vit c': ['ascorbic acid', 'vitamin c'],
  'vit c+': ['ascorbic acid', 'vitamin c'],
  'multivitamin': [
    'vitamin',
    'thiamine',
    'riboflavin',
    'b-complex',
    'মাল্টিভিটামিন',
  ],
  'b-complex': ['vit b', 'thiamine', 'pyridoxine', 'vitamin b'],
  'calcium': ['mineral', 'nutrition', 'calc', 'ক্যালসিয়াম'],
  'electrolyte': ['tonic', 'nutrition', 'saline', 'ইলেক্ট্রোলাইট'],
  'tonic': ['feed additive', 'nutrition', 'electrolyte', 'growth promoter'],
  'feed': ['additive', 'nutrition', 'feed additive', 'ফিস ফিড', 'পোল্ট্রি ফিড'],

  // Symptoms & Indications
  'paracetamol': ['acetaminophen', 'pyrexia', 'fever', 'analgesic'],
  'fever': ['pyrexia', 'paracetamol', 'fever reducer', 'জ্বর'],
  'pyrexia': ['fever', 'paracetamol'],
  'pain': ['analgesic', 'painkiller', 'anti-inflammatory', 'ব্যথা'],
  'cough': ['respiratory', 'cold', 'bronchitis', 'কাশি'],
  'diarrhea': ['enteritis', 'scours', 'loose motion', 'ডায়রিয়া'],
  'mastitis': ['udder infection', 'udder', 'ওলান ফোলা'],
  'bloat': ['tympanites', 'rumen bloat', 'পেট ফাঁপা'],
  'stress': ['anti-stress', 'heat stress'],

  // Dosage Forms & Categories
  'vet': ['veterinary', 'পশুপাখি', 'ভেটেরিনারি'],
  'veterinary': ['vet'],
  'bolus': ['tablet', 'bolus tablet', 'বোলস'],
  'injection': ['inj', 'injectable', 'ইনজেকশন'],
  'inj': ['injection', 'injectable'],
  'powder': ['wsp', 'water soluble powder', 'পাউডার'],
  'solution': ['liquid', 'oral solution', 'লিকুইড'],
  'suspension': ['susp', 'oral suspension'],

  // Livestock & Target Species
  'poultry': ['chicken', 'broiler', 'layer', 'পোল্ট্রি', 'মুরগি'],
  'chicken': ['poultry', 'broiler', 'layer'],
  'cattle': ['bovine', 'cow', 'ruminant', 'গরু'],
  'bovine': ['cattle', 'cow', 'ruminant'],
  'ruminant': ['cattle', 'goat', 'sheep', 'ছাগল'],
};

/// Expands a clean search token into synonym alternatives if present.
List<String> getSynonymExpansions(String token) {
  final lower = token.toLowerCase();
  final matches = <String>[lower];
  final synonyms = _searchSynonyms[lower];
  if (synonyms != null) {
    matches.addAll(synonyms);
  }
  return matches;
}

/// Common English and Bangla search stopwords to filter from multi-word queries.
const Set<String> _searchStopwords = {
  'a',
  'an',
  'the',
  'for',
  'with',
  'and',
  'or',
  'in',
  'of',
  'to',
  'is',
  'it',
  'by',
  'on',
  'at',
  'এবং',
  'ও',
  'জন্য',
  'সাথে',
  'দিয়ে',
  'দ্বারা',
  'সহ',
};

/// Sanitizes search tokens (preserving alphanumeric and Bengali characters)
/// to make them safe for SQLite FTS5 matching, joining multiple terms with AND.
/// Includes optional synonym expansion and stopword filtering for multi-word queries.
String sanitizeFtsQuery(
  String query, {
  bool enableSynonyms = true,
  bool filterStopwords = true,
}) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return '';
  var rawTokens = trimmed
      .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
      .trim()
      .split(RegExp(r'\s+'))
      .where((t) => t.isNotEmpty)
      .toList();

  if (rawTokens.isEmpty) return '';

  // Filter stopwords only if there are multiple tokens present
  if (filterStopwords && rawTokens.length > 1) {
    final filtered = rawTokens
        .where((t) => !_searchStopwords.contains(t.toLowerCase()))
        .toList();
    if (filtered.isNotEmpty) {
      rawTokens = filtered;
    }
  }

  final tokenGroupList = <String>[];
  for (final rawToken in rawTokens) {
    if (enableSynonyms) {
      final expanded = getSynonymExpansions(rawToken);
      if (expanded.length > 1) {
        final group = expanded.map((t) => '"$t"*').join(' OR ');
        tokenGroupList.add('($group)');
      } else {
        tokenGroupList.add('"${expanded.first}"*');
      }
    } else {
      tokenGroupList.add('"$rawToken"*');
    }
  }

  return tokenGroupList.join(' AND ');
}

/// Optimizes FTS index segments for maximum query performance post-sync or setup.
Future<void> optimizeFtsTable(QueryExecutor db, String tableName) async {
  try {
    await db.runCustom(
      "INSERT INTO $tableName($tableName) VALUES('optimize');",
    );
  } catch (e, st) {
    debugPrint('FTS optimization error for $tableName: $e\n$st');
  }
}

/// Optimizes all FTS indexes across products, distributors, sales personnel, and vet doctors.
Future<void> optimizeAllFtsTables(QueryExecutor db) async {
  final tables = [
    'products_fts',
    'products_trigram_fts',
    'distributors_fts',
    'sales_personnel_fts',
    'vet_doctors_fts',
  ];
  for (final table in tables) {
    await optimizeFtsTable(db, table);
  }
}

/// Checks if an FTS table is fully populated and marked ready in db_meta.
Future<bool> isFtsReady(QueryExecutor db, String tableName) async {
  try {
    final rows = await db.runSelect(
      "SELECT value FROM db_meta WHERE key = ? LIMIT 1",
      ['fts_ready_$tableName'],
    );
    return rows.isNotEmpty && rows.first['value'] == '1';
  } catch (_) {
    return false;
  }
}

/// Calculates Levenshtein distance between two strings for fuzzy matching/typo tolerance.
int levenshteinDistance(String s1, String s2) {
  final a = s1.toLowerCase();
  final b = s2.toLowerCase();
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;

  List<int> v0 = List<int>.generate(b.length + 1, (i) => i);
  final List<int> v1 = List<int>.filled(b.length + 1, 0);

  for (int i = 0; i < a.length; i++) {
    v1[0] = i + 1;
    for (int j = 0; j < b.length; j++) {
      final cost = (a.codeUnitAt(i) == b.codeUnitAt(j)) ? 0 : 1;
      v1[j + 1] = [
        v1[j] + 1,
        v0[j + 1] + 1,
        v0[j] + cost,
      ].reduce((curr, next) => curr < next ? curr : next);
    }
    v0 = List<int>.from(v1);
  }

  return v1[b.length];
}

/// Calculates similarity score between 0.0 (completely different) and 1.0 (exact match).
double calculateSimilarity(String s1, String s2) {
  final a = s1.trim().toLowerCase();
  final b = s2.trim().toLowerCase();
  if (a == b) return 1.0;
  if (a.isEmpty || b.isEmpty) return 0.0;
  final maxLen = a.length > b.length ? a.length : b.length;
  if (maxLen == 0) return 1.0;
  final dist = levenshteinDistance(a, b);
  return 1.0 - (dist / maxLen);
}

/// Computes phonetic similarity score (0.0 to 1.0) using simplified phonetic keys.
double calculatePhoneticSimilarity(String s1, String s2) {
  final key1 = getPhoneticKey(s1);
  final key2 = getPhoneticKey(s2);
  if (key1 == key2 && key1.isNotEmpty) return 1.0;
  return calculateSimilarity(key1, key2);
}

/// Checks whether any word in target matches queryToken within similarity threshold or substring.
bool matchesFuzzyToken(
  String target,
  String queryToken, {
  double threshold = 0.65,
}) {
  final cleanTarget = target.trim().toLowerCase();
  final cleanQuery = queryToken.trim().toLowerCase();
  if (cleanTarget.isEmpty || cleanQuery.isEmpty) return false;
  if (cleanTarget.contains(cleanQuery)) return true;

  final words = cleanTarget.split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
  for (final word in words) {
    if (word.contains(cleanQuery) || cleanQuery.contains(word)) {
      return true;
    }
    if (calculateSimilarity(word, cleanQuery) >= threshold) {
      return true;
    }
    if (calculatePhoneticSimilarity(word, cleanQuery) >= threshold + 0.05) {
      return true;
    }
  }
  return calculateSimilarity(cleanTarget, cleanQuery) >= threshold;
}

/// Input payload container for isolate fuzzy scoring calculations.
class FuzzyCandidateInput {
  final String query;
  final List<Map<String, dynamic>> candidates;

  const FuzzyCandidateInput({required this.query, required this.candidates});
}

/// Top-level isolate function for compute() / Isolate.run() to process alike / fuzzy scoring off the main UI thread.
List<Map<String, dynamic>> computeFuzzyFallbackScores(
  FuzzyCandidateInput input,
) {
  final trimmed = input.query.trim().toLowerCase();
  if (trimmed.length < 2) return [];
  final phoneticQuery = getPhoneticKey(trimmed);

  final scored = <Map<String, dynamic>>[];
  for (final row in input.candidates) {
    final titleEn = (row['title_en'] as String? ?? '').toLowerCase();
    final titleBn = (row['title_bn'] as String? ?? '').toLowerCase();
    final catEn =
        (row['cat_en'] as String? ?? row['cat_name_en'] as String? ?? '')
            .toLowerCase();
    final catBn =
        (row['cat_bn'] as String? ?? row['cat_name_bn'] as String? ?? '')
            .toLowerCase();
    final comp = (row['comp_ingredients'] as String? ?? '').toLowerCase();
    final ind = (row['ind_text'] as String? ?? '').toLowerCase();

    int minDistance = 999;

    void evaluateTarget(String target, int penalty) {
      if (target.isEmpty) return;
      final words = target.split(RegExp(r'\s+'));
      for (final word in words) {
        if (word.isEmpty) continue;
        // Direct string Levenshtein
        final dist = levenshteinDistance(trimmed, word) + penalty;
        if (dist < minDistance) minDistance = dist;

        // Phonetic key Levenshtein (enables sound-alike transliteration matching)
        if (phoneticQuery.isNotEmpty) {
          final wordPhonetic = getPhoneticKey(word);
          if (wordPhonetic.isNotEmpty) {
            final pDist =
                levenshteinDistance(phoneticQuery, wordPhonetic) + penalty;
            if (pDist < minDistance) minDistance = pDist;
          }
        }
      }
      final fullDist = levenshteinDistance(trimmed, target) + penalty;
      if (fullDist < minDistance) minDistance = fullDist;
    }

    // Evaluate product title (penalty 0)
    evaluateTarget(titleEn, 0);
    evaluateTarget(titleBn, 0);

    // Evaluate category (penalty 2)
    evaluateTarget(catEn, 2);
    evaluateTarget(catBn, 2);

    // Evaluate compositions & indications (penalty 3)
    evaluateTarget(comp, 3);
    evaluateTarget(ind, 3);

    final maxAllowed = trimmed.length <= 4 ? 1 : (trimmed.length <= 7 ? 2 : 3);
    if (minDistance <= maxAllowed) {
      scored.add({'row': row, 'score': minDistance});
    }
  }

  scored.sort((a, b) => (a['score'] as int).compareTo(b['score'] as int));
  return scored.map((e) => e['row'] as Map<String, dynamic>).toList();
}

/// Computes a simplified phonetic key for English and Bengali text to match transliterated names and alike sounding words.
String getPhoneticKey(String text) {
  final cleaned = text.trim().toLowerCase();
  if (cleaned.isEmpty) return '';

  // 1. Remove non-alphanumeric and non-Bengali characters
  var s = cleaned.replaceAll(RegExp(r'[^\w\u0980-\u09FF]'), '');

  // 2. English consonant simplification & homophone mapping (Soundex / Double Metaphone rules)
  s = s
      .replaceAll(RegExp('ph'), 'f')
      .replaceAll(RegExp('gh'), 'g')
      .replaceAll(RegExp('ck'), 'k')
      .replaceAll(RegExp('c([eiy])'), r's$1')
      .replaceAll(RegExp('c'), 'k')
      .replaceAll(RegExp('q'), 'k')
      .replaceAll(RegExp('x'), 'ks')
      .replaceAll(RegExp('z'), 's')
      .replaceAll(RegExp('v'), 'b')
      .replaceAll(RegExp('w'), 'b')
      .replaceAll(RegExp('th'), 't')
      .replaceAll(RegExp('ee'), 'i')
      .replaceAll(RegExp('oo'), 'u')
      .replaceAll(RegExp('ae'), 'e')
      .replaceAll(RegExp('y'), 'i');

  // 3. Bengali vowel & consonant normalization
  s = s
      .replaceAll(RegExp('[আঅঅা]'), 'a')
      .replaceAll(RegExp('[ইঈিী]'), 'i')
      .replaceAll(RegExp('[উঊুূ]'), 'u')
      .replaceAll(RegExp('[এে]'), 'e')
      .replaceAll(RegExp('[ওো]'), 'o')
      .replaceAll(RegExp('[কখ]'), 'k')
      .replaceAll(RegExp('[গঘ]'), 'g')
      .replaceAll(RegExp('[চছ]'), 's')
      .replaceAll(RegExp('[জঝযয্‌]'), 'j')
      .replaceAll(RegExp('[টঠতথদ্বধ]'), 't')
      .replaceAll(RegExp('[ডঢদধ]'), 'd')
      .replaceAll(RegExp('[পফ]'), 'f')
      .replaceAll(RegExp('[বভ]'), 'b')
      .replaceAll(RegExp('[ম]'), 'm')
      .replaceAll(RegExp('[রড়ঢ়]'), 'r')
      .replaceAll(RegExp('[ল]'), 'l')
      .replaceAll(RegExp('[শষস]'), 's')
      .replaceAll(RegExp('[হ]'), 'h')
      .replaceAll(RegExp('[নণ]'), 'n');

  // 4. Collapse adjacent identical characters
  final buffer = StringBuffer();
  String? prev;
  for (int i = 0; i < s.length; i++) {
    final char = s[i];
    if (char != prev) {
      buffer.write(char);
      prev = char;
    }
  }

  return buffer.toString();
}

/// Trie Node representation for fast client-side autocomplete.
class TrieNode {
  final Map<String, TrieNode> children = {};
  bool isEndOfWord = false;
  int frequency = 0;
  String originalText = '';
}

/// Fast in-memory Autocomplete Trie data structure for zero-latency suggestions.
class AutocompleteTrie {
  final TrieNode root = TrieNode();

  /// Inserts a string into the trie index.
  void insert(String word) {
    final trimmed = word.trim();
    if (trimmed.isEmpty) return;

    var current = root;
    for (final char in trimmed.toLowerCase().codeUnits) {
      final key = String.fromCharCode(char);
      current = current.children.putIfAbsent(key, TrieNode.new);
    }
    current.isEndOfWord = true;
    current.frequency++;
    current.originalText = trimmed;
  }

  /// Populates the trie with a list of search terms.
  void populate(Iterable<String> terms) {
    for (final term in terms) {
      insert(term);
    }
  }

  /// Retrieves prefix suggestions ordered by frequency & match quality.
  List<String> getSuggestions(String prefix, {int maxResults = 5}) {
    final trimmed = prefix.trim().toLowerCase();
    if (trimmed.isEmpty) return const [];

    var current = root;
    for (final char in trimmed.codeUnits) {
      final key = String.fromCharCode(char);
      if (!current.children.containsKey(key)) return const [];
      current = current.children[key]!;
    }

    final results = <MapEntry<String, int>>[];
    _dfs(current, results);
    results.sort((a, b) => b.value.compareTo(a.value));

    return results
        .take(maxResults)
        .map((e) => e.key)
        .where((s) => s.isNotEmpty)
        .toList();
  }

  void _dfs(TrieNode node, List<MapEntry<String, int>> results) {
    if (node.isEndOfWord && node.originalText.isNotEmpty) {
      results.add(MapEntry(node.originalText, node.frequency));
    }
    node.children.forEach((_, child) {
      _dfs(child, results);
    });
  }
}

/// Generic LRU Cache for caching recent query results in memory.
class SearchQueryCache<T> {
  final int capacity;
  final Map<String, List<T>> _cache = {};
  final List<String> _keys = [];

  SearchQueryCache({this.capacity = 50});

  List<T>? get(String query) {
    final key = query.trim().toLowerCase();
    if (!_cache.containsKey(key)) return null;

    // Move key to back of LRU tracking queue
    _keys.remove(key);
    _keys.add(key);
    return _cache[key];
  }

  void put(String query, List<T> results) {
    final key = query.trim().toLowerCase();
    if (key.isEmpty) return;

    if (_cache.containsKey(key)) {
      _keys.remove(key);
    } else if (_keys.length >= capacity) {
      final lruKey = _keys.removeAt(0);
      _cache.remove(lruKey);
    }

    _cache[key] = results;
    _keys.add(key);
  }

  void clear() {
    _cache.clear();
    _keys.clear();
  }
}

/// Represents facet value and item frequency count for dynamic search filtering.
class FacetCount {
  final String value;
  final int count;

  const FacetCount(this.value, this.count);
}

/// Calculates dynamic facet aggregations (e.g. category, brand, target group counts) across search result items.
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
      final val = extractor(item).trim();
      if (val.isNotEmpty) {
        counts[val] = (counts[val] ?? 0) + 1;
      }
    }

    final facetList =
        counts.entries.map((e) => FacetCount(e.key, e.value)).toList()
          ..sort((a, b) => b.count.compareTo(a.count));

    result[facetName] = facetList;
  }

  return result;
}

/// Combines multiple ranked candidate result sets (e.g. Sparse BM25 FTS, Trigram, Scope LIKE, Fuzzy)
/// into a single unified hybrid result list using Reciprocal Rank Fusion (RRF).
/// RRF score for document d: RRF_Score(d) = sum_{m in M} (1 / (k + r_m(d)))
List<T> reciprocalRankFusion<T>({
  required List<List<T>> rankedResultLists,
  required String Function(T) getId,
  int k = 60,
}) {
  if (rankedResultLists.isEmpty) return const [];
  if (rankedResultLists.length == 1) return rankedResultLists.first;

  final rrfScores = <String, double>{};
  final itemMap = <String, T>{};

  for (final resultList in rankedResultLists) {
    for (int rank = 0; rank < resultList.length; rank++) {
      final item = resultList[rank];
      final id = getId(item);
      itemMap.putIfAbsent(id, () => item);

      // Add reciprocal rank contribution for this list: 1.0 / (k + rank_1_indexed)
      final rankScore = 1.0 / (k + (rank + 1));
      rrfScores[id] = (rrfScores[id] ?? 0.0) + rankScore;
    }
  }

  final sortedIds = rrfScores.keys.toList()
    ..sort((a, b) => rrfScores[b]!.compareTo(rrfScores[a]!));

  return sortedIds.map((id) => itemMap[id]!).toList();
}
