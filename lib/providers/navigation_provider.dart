import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

/// Manages the selected tab index of the main screen navigation.
/// 0: Products Directory, 1: Manufacturers, 2: Contact Details
@Riverpod(keepAlive: true)
class MainNavIndex extends _$MainNavIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    if (state != index) {
      state = index;
    }
  }
}
