import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/models/product.dart';

void main() {
  group('Benefit Model Tests', () {
    test('Benefit.fromRow creates instance correctly', () {
      final row = {
        'id': 10,
        'product_id': 5,
        'text_en': 'Boosts weight gain',
        'text_bn': 'ওজন বৃদ্ধি করে',
        'display_order': 2,
      };

      final benefit = Benefit.fromRow(row);

      expect(benefit.id, 10);
      expect(benefit.productId, 5);
      expect(benefit.textEn, 'Boosts weight gain');
      expect(benefit.textBn, 'ওজন বৃদ্ধি করে');
      expect(benefit.displayOrder, 2);
    });

    test('Benefit constructor defaults displayOrder to 0', () {
      const benefit = Benefit(
        id: 1,
        productId: 2,
        textEn: 'Improves digestion',
      );

      expect(benefit.id, 1);
      expect(benefit.productId, 2);
      expect(benefit.textEn, 'Improves digestion');
      expect(benefit.textBn, isNull);
      expect(benefit.displayOrder, 0);
    });

    test('Benefit supports value equality and copyWith', () {
      const b1 = Benefit(id: 1, productId: 1, textEn: 'Healthy growth');
      final b2 = b1.copyWith(textBn: 'সুস্থ বৃদ্ধি');

      expect(b1 == b2, isFalse);
      expect(b2.textBn, 'সুস্থ বৃদ্ধি');
      expect(b2.id, 1);
      expect(b2.productId, 1);
      expect(b2.textEn, 'Healthy growth');
    });
  });
}
