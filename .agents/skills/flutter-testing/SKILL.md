---
name: flutter-testing
description: Use when writing unit tests, widget tests, provider tests, database tests, golden tests, or integration tests in this Flutter project.
---

# Flutter Testing Guide

A comprehensive guide for writing reliable, maintainable, and fast unit, widget, state management, database, and integration tests in Flutter.

---

## 1. Test Architecture & Directory Structure

Organize tests in the `test/` directory mirroring `lib/` structure:

```
test/
├── features/
│   ├── auth/
│   │   ├── data/auth_repository_test.dart
│   │   ├── domain/auth_usecase_test.dart
│   │   └── presentation/login_screen_test.dart
│   └── wallet/
│       ├── providers/wallet_provider_test.dart
│       └── widgets/balance_card_test.dart
├── core/
│   ├── database/drift_database_test.dart
│   └── network/api_client_test.dart
├── helpers/
│   ├── mock_data.dart
│   ├── test_wrapper.dart
│   └── test_providers.dart
└── flutter_test_config.dart
```

---

## 2. Unit Testing

Focus on testing isolated logic, data transformers, entities, and repositories.

### Key Rules & Best Practices
- **Isolation**: Test single units without executing real dependencies (APIs, disk, databases).
- **Mocking**: Use `mocktail` for null-safe, clean, non-code-gen mocks.
- **Grouping**: Group tests logically by function or scenario using `group()`.
- **AAA Pattern**: Arrange, Act, Assert.

### Unit Test Example (Mocktail)

When using `any()` or `any(that: ...)` matchers with custom non-primitive parameters in `mocktail`, register fallback values in `setUpAll`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}
class FakeUser extends Fake implements User {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUser());
  });

  late MockApiClient mockApiClient;
  late UserRepository repository;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = UserRepository(apiClient: mockApiClient);
  });

  group('UserRepository', () {
    test('getUserById returns User on successful API response', () async {
      // Arrange
      const userId = '123';
      const expectedUser = User(id: userId, name: 'Alice');
      when(() => mockApiClient.fetchUser(userId))
          .thenAnswer((_) async => {'id': '123', 'name': 'Alice'});

      // Act
      final result = await repository.getUserById(userId);

      // Assert
      expect(result, equals(expectedUser));
      verify(() => mockApiClient.fetchUser(userId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('getUserById throws NetworkException on API failure', () async {
      // Arrange
      when(() => mockApiClient.fetchUser(any()))
          .thenThrow(NetworkException('Server connection failed'));

      // Act & Assert
      expect(
        () => repository.getUserById('123'),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
```

---

## 3. Riverpod State Management Testing

Test Notifiers, AsyncNotifiers, and Providers in complete isolation using `ProviderContainer`.

### Testing AsyncNotifiers & `AsyncValue` Lifecycle

When testing `AsyncNotifier` or `FutureProvider`, verify `AsyncLoading`, `AsyncData`, and `AsyncError` transitions:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  test('userNotifier emits [AsyncLoading, AsyncData] on successful fetch', () async {
    const user = User(id: '1', name: 'Alice');
    when(() => mockAuthRepository.fetchUser('1')).thenAnswer((_) async => user);

    final listener = Listener<AsyncValue<User>>();
    container.listen(
      userNotifierProvider('1'),
      listener.call,
      fireImmediately: true,
    );

    // Initial state is loading
    expect(
      container.read(userNotifierProvider('1')),
      isA<AsyncLoading<User>>(),
    );

    // Wait for the async notifier to initialize/complete
    await container.read(userNotifierProvider('1').future);

    verifyInOrder([
      () => listener(null, isA<AsyncLoading<User>>()),
      () => listener(isA<AsyncLoading<User>>(), const AsyncData(user)),
    ]);
  });
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
```

---

## 4. Drift Database Testing

Test Drift tables, DAOs, and queries using in-memory SQLite (`NativeDatabase.memory()`).

```dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    // Create in-memory database for isolated test context
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('TokenDao Tests', () {
    test('insert and retrieve token', () async {
      final token = TokensCompanion.insert(
        symbol: 'USDT',
        name: 'Tether USD',
        balance: 100.0,
      );

      await db.tokenDao.insertToken(token);

      final tokens = await db.tokenDao.getAllTokens();
      expect(tokens.length, equals(1));
      expect(tokens.first.symbol, equals('USDT'));
      expect(tokens.first.balance, equals(100.0));
    });

    test('watchAllTokens emits updated values when row is added', () async {
      final expectation = expectLater(
        db.tokenDao.watchAllTokens(),
        emitsInOrder([
          isEmpty,
          hasLength(1),
        ]),
      );

      await db.tokenDao.insertToken(
        TokensCompanion.insert(symbol: 'ETH', name: 'Ethereum', balance: 2.5),
      );

      await expectation;
    });
  });
}
```

---

## 5. Widget Testing & Modern Viewport APIs

Test visual rendering, user interactions, layout logic, and responsive UI behaviors.

### Essential Widget Test Setup & Harness
Wrap widgets in a testing harness (`MaterialApp`, `ProviderScope`, `Directionality`) to provide required contexts.

```dart
Widget createWidgetUnderTest({
  required Widget child,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}
```

### Modern Screen Dimensions / Device Viewports (Flutter 3.27+ `tester.view`)

Use `tester.view` APIs and `addTearDown` cleanup hooks:

```dart
testWidgets('Renders mobile layout on narrow screens', (tester) async {
  // Set physical viewport size (e.g. iPhone 13)
  tester.view.physicalSize = const Size(390 * 3, 844 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(createWidgetUnderTest(child: const ResponsiveDashboard()));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('bottom_nav_bar')), findsOneWidget);
  expect(find.byKey(const Key('side_drawer')), findsNothing);
});
```

---

## 6. Golden Testing & Visual Regressions

Compare rendered widget UI pixel-for-pixel against baseline images.

```dart
testWidgets('CustomCard visual golden test', (tester) async {
  await tester.pumpWidget(
    createWidgetUnderTest(
      child: const CustomCard(
        title: 'Impulse DEX',
        subtitle: 'Decentralized Exchange',
      ),
    ),
  );

  await tester.pumpAndSettle();

  // Match golden image asset
  await expectLater(
    find.byType(CustomCard),
    matchesGoldenFile('goldens/custom_card.png'),
  );
});
```

---

## 7. Timer & FakeAsync Time Travel Testing

Test debounced inputs, periodic timers, or delayed animations accurately without real-world delays using `fakeAsync`:

```dart
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debounced search query fires only after timer duration', () {
    fakeAsync((async) {
      String query = '';
      final searchEngine = SearchEngine(onQuery: (q) => query = q);

      searchEngine.onTextChanged('B');
      searchEngine.onTextChanged('BT');
      searchEngine.onTextChanged('BTC');

      expect(query, isEmpty); // Debounce delay active

      async.elapse(const Duration(milliseconds: 300));
      expect(query, equals('BTC'));
    });
  });
}
```

---

## 8. Accessibility & Semantics Testing

Ensure buttons, tap targets, contrast, and accessibility labels meet criteria.

```dart
testWidgets('Meets tap target size and accessibility guidance', (tester) async {
  final SemanticsHandle handle = tester.ensureSemantics();

  await tester.pumpWidget(
    createWidgetUnderTest(
      child: const PrimaryButton(label: 'Submit'),
    ),
  );

  // Checks minimum 48x48 tap target guidelines
  await expectLater(tester, meetsGuidance(androidTapTargetGuidance));
  await expectLater(tester, meetsGuidance(labeledTapTargetGuidance));

  handle.dispose();
});
```

---

## 9. Integration & E2E Testing

Verify complete app user flows running on a real device or emulator using `integration_test`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:impulse_dex/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete checkout flow integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Interact with app widgets
    await tester.tap(find.byKey(const Key('product_card_1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('add_to_cart_button')));
    await tester.pumpAndSettle();

    expect(find.text('Item added to cart'), findsOneWidget);
  });
}
```

---

## 10. Network & HTTP Layer Mocking

Mock HTTP requests using `http/testing.dart` (`MockClient`) without network calls:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('ApiService fetches data successfully', () async {
    final client = MockClient((request) async {
      if (request.url.path == '/api/v1/products') {
        return http.Response('{"status": "ok"}', 200);
      }
      return http.Response('Not Found', 404);
    });

    final apiService = ApiService(client: client);
    final response = await apiService.getProducts();

    expect(response['status'], equals('ok'));
  });
}
```

---

## 11. Platform MethodChannel Mocking

Mock native platform channels cleanly using `TestDefaultBinaryMessengerBinding`:

```dart
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('com.example.app/native');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'getBatteryLevel') {
        return 85;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('Native battery level method channel test', () async {
    final int level = await channel.invokeMethod('getBatteryLevel');
    expect(level, equals(85));
  });
}
```

---

## 12. Custom Matchers & Test Helpers

Create reusable custom matchers for domain-specific assertions:

```dart
import 'package:flutter_test/flutter_test.dart';

Matcher isPositiveNumber() => _IsPositiveNumber();

class _IsPositiveNumber extends Matcher {
  @override
  bool matches(dynamic item, Map matchState) {
    return item is num && item > 0;
  }

  @override
  Description describe(Description description) {
    return description.add('is a positive number (> 0)');
  }
}
```

---

## 13. Test Tags & `dart_test.yaml` Configuration

Categorize tests using `@Tags` for targeted CI pipeline execution:

```dart
@Tags(['unit', 'fast'])
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fast mathematical calculation', () {
    expect(2 + 2, equals(4));
  });
}
```

Configure default tags in `dart_test.yaml`:

```yaml
tags:
  unit: "Fast unit tests without I/O"
  widget: "Widget rendering tests"
  database: "Drift database tests"
  golden: "Pixel golden image tests"
```

---

## 14. CLI Commands & Workflow

### Running Tests
- **Run all unit & widget tests**: `flutter test`
- **Run specific test file**: `flutter test test/features/auth/login_test.dart`
- **Run integration tests**: `flutter test integration_test/app_test.dart`
- **Run tests by tag**: `flutter test --tags unit`
- **Exclude heavy/golden tags**: `flutter test --exclude-tags golden`
- **Generate coverage report**: `flutter test --coverage`
- **Update golden images**: `flutter test --update-goldens`

### Static Code Verification
Always verify code quality and lints after creating or updating tests:
```bash
flutter analyze
```



