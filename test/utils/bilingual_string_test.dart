import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_app/utils/bilingual_string.dart';

void main() {
  group('BilingualString Extension Tests', () {
    test('resolve returns English text when language is en', () {
      const enText = 'Paracetamol';
      const bnText = 'প্যারাসিটামল';

      expect(enText.resolve(bnText, 'en'), equals('Paracetamol'));
    });

    test('resolve returns Bengali text when language is bn and bnText is present', () {
      const enText = 'Paracetamol';
      const bnText = 'প্যারাসিটামল';

      expect(enText.resolve(bnText, 'bn'), equals('প্যারাসিটামল'));
    });

    test('resolve falls back to English text when language is bn but bnText is empty or null', () {
      const enText = 'Paracetamol';
      expect(enText.resolve('', 'bn'), equals('Paracetamol'));
      expect(enText.resolve(null, 'bn'), equals('Paracetamol'));
    });
  });

  group('BilingualStringNullable Extension Tests', () {
    test('resolve on nullable String handles null values gracefully', () {
      const String? nullString = null;
      expect(nullString.resolve('বাংলা', 'bn'), equals('বাংলা'));
      expect(nullString.resolve('বাংলা', 'en'), equals(''));
      expect(nullString.resolve(null, 'bn'), equals(''));
    });
  });

  group('LangHelper Extension Tests', () {
    test('isBn identifies bn language code correctly', () {
      expect('bn'.isBn, isTrue);
      expect('en'.isBn, isFalse);
    });
  });
}
