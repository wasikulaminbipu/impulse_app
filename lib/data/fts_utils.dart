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

/// Checks whether any word in target matches queryToken within similarity threshold or substring.
bool matchesFuzzyToken(String target, String queryToken, {double threshold = 0.65}) {
  final cleanTarget = target.trim().toLowerCase();
  final cleanQuery = queryToken.trim().toLowerCase();
  if (cleanTarget.isEmpty || cleanQuery.isEmpty) return false;
  if (cleanTarget.contains(cleanQuery)) return true;

  final words = cleanTarget.split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
  for (final word in words) {
    if (word.contains(cleanQuery) || cleanQuery.contains(word)) return true;
    if (calculateSimilarity(word, cleanQuery) >= threshold) return true;
  }
  return calculateSimilarity(cleanTarget, cleanQuery) >= threshold;
}

/// Computes a simplified phonetic key for English and Bengali text to match transliterated names.
String getPhoneticKey(String text) {
  final cleaned = text.trim().toLowerCase();
  if (cleaned.isEmpty) return '';

  // 1. Remove non-alphanumeric and non-Bengali characters
  var s = cleaned.replaceAll(RegExp(r'[^\w\u0980-\u09FF]'), '');

  // 2. English consonant simplification & homophone mapping
  s = s
      .replaceAll(RegExp(r'ph'), 'f')
      .replaceAll(RegExp(r'gh'), 'g')
      .replaceAll(RegExp(r'ck'), 'k')
      .replaceAll(RegExp(r'c([eiy])'), 's\$1')
      .replaceAll(RegExp(r'c'), 'k')
      .replaceAll(RegExp(r'z'), 's')
      .replaceAll(RegExp(r'v'), 'b')
      .replaceAll(RegExp(r'w'), 'b')
      .replaceAll(RegExp(r'ee'), 'i')
      .replaceAll(RegExp(r'oo'), 'u')
      .replaceAll(RegExp(r'ae'), 'e');

  // 3. Bengali vowel & consonant normalization
  s = s
      .replaceAll(RegExp(r'[আঅঅা]'), 'a')
      .replaceAll(RegExp(r'[ইঈিী]'), 'i')
      .replaceAll(RegExp(r'[উঊুূ]'), 'u')
      .replaceAll(RegExp(r'[এে]'), 'e')
      .replaceAll(RegExp(r'[ওো]'), 'o')
      .replaceAll(RegExp(r'[কখ]'), 'k')
      .replaceAll(RegExp(r'[গঘ]'), 'g')
      .replaceAll(RegExp(r'[চছ]'), 's')
      .replaceAll(RegExp(r'[জঝযয্‌]'), 'j')
      .replaceAll(RegExp(r'[টঠতথদ্বধ]'), 't')
      .replaceAll(RegExp(r'[ডঢদধ]'), 'd')
      .replaceAll(RegExp(r'[পফ]'), 'f')
      .replaceAll(RegExp(r'[বভ]'), 'b')
      .replaceAll(RegExp(r'[ম]'), 'm')
      .replaceAll(RegExp(r'[রড়ঢ়]'), 'r')
      .replaceAll(RegExp(r'[ল]'), 'l')
      .replaceAll(RegExp(r'[শষস]'), 's')
      .replaceAll(RegExp(r'[হ]'), 'h');

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


