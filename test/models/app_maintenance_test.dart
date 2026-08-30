import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/app_maintenance.dart';

void main() {
  group('FavoriteType Enum Tests', () {
    test('FavoriteType enum properties match database columns', () {
      expect(FavoriteType.product.table, equals('favorite_products'));
      expect(FavoriteType.product.idColumn, equals('product_id'));
      expect(FavoriteType.distributor.table, equals('favorite_distributors'));
      expect(FavoriteType.distributor.idColumn, equals('distributor_id'));
      expect(FavoriteType.salesPersonnel.table, equals('favorite_sales_personnel'));
      expect(FavoriteType.salesPersonnel.idColumn, equals('sales_personnel_id'));
      expect(FavoriteType.vetDoctor.table, equals('favorite_vet_doctors'));
      expect(FavoriteType.vetDoctor.idColumn, equals('vet_doctor_id'));
    });
  });

  group('FavoriteEntry Freezed Model Tests', () {
    test('FavoriteEntry.fromMap creates instance properly', () {
      final nowStr = '2026-08-24T10:00:00.000Z';
      final map = {
        'product_id': 42,
        'added_at': nowStr,
      };

      final entry = FavoriteEntry.fromMap(map, 'product_id');
      expect(entry.id, equals(42));
      expect(entry.addedAt, equals(DateTime.parse(nowStr)));
    });
  });

  group('AppSetting Freezed Model Tests', () {
    test('AppSetting.fromMap and toMap convert correctly', () {
      final map = {'key': 'theme_mode', 'value': 'dark'};
      final setting = AppSetting.fromMap(map);

      expect(setting.key, equals('theme_mode'));
      expect(setting.value, equals('dark'));
      expect(setting.toMap(), equals(map));
    });
  });
}
