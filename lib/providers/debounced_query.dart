import 'dart:async';

mixin DebouncedQuery {
  Timer? _timer;
  Duration get debounceDuration => const Duration(milliseconds: 300);

  void debouncedUpdate(String query, void Function(String) updateState) {
    _timer?.cancel();
    if (query.isEmpty) {
      updateState('');
      return;
    }
    _timer = Timer(debounceDuration, () => updateState(query));
  }

  void cancelDebounce() {
    _timer?.cancel();
  }
}
