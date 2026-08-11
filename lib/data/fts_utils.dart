import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';

/// Pharmaceutical, veterinary, and generic search synonym dictionary.
const Map<String, List<String>> _searchSynonyms = {
  'amox': ['amoxicillin'],
  'cipro': ['ciprofloxacin'],
  'vit': ['vitamin'],
  'vit c': ['ascorbic acid', 'vitamin c'],
  'vit c+': ['ascorbic acid'],
  'paracetamol': ['acetaminophen', 'pyrexia'],
  'doxy': ['doxycycline'],
  'oxy': ['oxytetracycline'],
  'vet': ['veterinary'],
  'feed': ['additive', 'nutrition'],
  'anthelmintic': ['dewormer', 'wormer'],
  'antibiotic': ['antimicrobial', 'bactericidal'],
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

/// Sanitizes search tokens (preserving alphanumeric and Bengali characters)
/// to make them safe for SQLite FTS5 matching, joining multiple terms with AND.
/// Includes optional synonym expansion.
String sanitizeFtsQuery(String query, {bool enableSynonyms = true}) {
  final trimmed = query.trim();
  if (trimmed.isEmpty) return '';
  final rawTokens = trimmed
      .replaceAll(RegExp(r'[^\w\s\u0980-\u09FF]'), ' ')
      .trim()
      .split(RegExp(r'\s+'))
      .where((t) => t.isNotEmpty);
  
  if (rawTokens.isEmpty) return '';

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
    await db.runCustom("INSERT INTO $tableName($tableName) VALUES('optimize');");
  } catch (e, st) {
    debugPrint('FTS optimization error for $tableName: $e\n$st');
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
  List<int> v1 = List<int>.filled(b.length + 1, 0);

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
      current = current.children.putIfAbsent(key, () => TrieNode());
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


