import 'package:flutter/foundation.dart';

/// Telemetry event capturing search parameters, performance metrics, and zero-result tracking.
class SearchAnalyticsEvent {
  final String query;
  final int resultCount;
  final int executionTimeMs;
  final DateTime timestamp;
  final String? categoryOrScope;

  SearchAnalyticsEvent({
    required this.query,
    required this.resultCount,
    required this.executionTimeMs,
    required this.timestamp,
    this.categoryOrScope,
  });

  Map<String, dynamic> toJson() => {
        'query': query,
        'result_count': resultCount,
        'execution_time_ms': executionTimeMs,
        'timestamp': timestamp.toIso8601String(),
        'category_or_scope': categoryOrScope,
        'is_zero_result': resultCount == 0,
      };
}

/// Search analytics tracker for monitoring latency, search conversion, and zero-result queries.
class SearchAnalyticsTracker {
  static final List<SearchAnalyticsEvent> _recentLogs = [];
  static const int _maxLogSize = 100;

  static void logSearch({
    required String query,
    required int resultCount,
    required int executionTimeMs,
    String? categoryOrScope,
  }) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final event = SearchAnalyticsEvent(
      query: trimmed.toLowerCase(),
      resultCount: resultCount,
      executionTimeMs: executionTimeMs,
      timestamp: DateTime.now(),
      categoryOrScope: categoryOrScope,
    );

    _recentLogs.insert(0, event);
    if (_recentLogs.length > _maxLogSize) {
      _recentLogs.removeLast();
    }

    if (kDebugMode) {
      if (resultCount == 0) {
        debugPrint(
          '[SearchAnalytics] ⚠️ Zero-result query logged: "$trimmed" (took ${executionTimeMs}ms, scope: $categoryOrScope)',
        );
      } else {
        debugPrint(
          '[SearchAnalytics] 🔍 Search executed: "$trimmed" -> $resultCount results in ${executionTimeMs}ms',
        );
      }
    }
  }

  static List<SearchAnalyticsEvent> getRecentLogs() => List.unmodifiable(_recentLogs);

  static double getZeroResultRate() {
    if (_recentLogs.isEmpty) return 0.0;
    final zeroCount = _recentLogs.where((e) => e.resultCount == 0).length;
    return zeroCount / _recentLogs.length;
  }
}
