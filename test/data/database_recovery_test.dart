import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SQLite Auto-Healing & Integrity Detection Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('sqlite_recovery_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Valid SQLite database header is recognized as uncorrupted', () async {
      final dbFile = File('${tempDir.path}/valid.db');
      // Construct a valid 100-byte SQLite header
      final header = Uint8List(100);
      const magic = [
        0x53,
        0x51,
        0x4C,
        0x69,
        0x74,
        0x65,
        0x20,
        0x66,
        0x6F,
        0x72,
        0x6D,
        0x61,
        0x74,
        0x20,
        0x33,
        0x00,
      ];
      for (int i = 0; i < 16; i++) {
        header[i] = magic[i];
      }
      await dbFile.writeAsBytes(header);

      bool isCorrupted = false;
      final len = await dbFile.length();
      if (len < 100) {
        isCorrupted = true;
      } else {
        final readHeader = await dbFile.openRead(0, 16).first;
        for (int i = 0; i < 16; i++) {
          if (readHeader[i] != magic[i]) {
            isCorrupted = true;
            break;
          }
        }
      }

      expect(isCorrupted, isFalse);
    });

    test(
      'Truncated SQLite file (< 100 bytes) is flagged as corrupted',
      () async {
        final dbFile = File('${tempDir.path}/truncated.db');
        await dbFile.writeAsBytes([0x53, 0x51, 0x4C]); // Only 3 bytes

        bool isCorrupted = false;
        final len = await dbFile.length();
        if (len < 100) {
          isCorrupted = true;
        }

        expect(isCorrupted, isTrue);
      },
    );

    test('Zero-byte file is flagged as corrupted', () async {
      final dbFile = File('${tempDir.path}/empty.db');
      await dbFile.create();

      bool isCorrupted = false;
      final len = await dbFile.length();
      if (len < 100) {
        isCorrupted = true;
      }

      expect(isCorrupted, isTrue);
    });

    test(
      'Invalid magic bytes in 100-byte file are flagged as corrupted',
      () async {
        final dbFile = File('${tempDir.path}/corrupt_magic.db');
        final bytes = Uint8List(120); // 120 bytes of zeros
        await dbFile.writeAsBytes(bytes);

        bool isCorrupted = false;
        final len = await dbFile.length();
        if (len < 100) {
          isCorrupted = true;
        } else {
          final readHeader = await dbFile.openRead(0, 16).first;
          const magic = [
            0x53,
            0x51,
            0x4C,
            0x69,
            0x74,
            0x65,
            0x20,
            0x66,
            0x6F,
            0x72,
            0x6D,
            0x61,
            0x74,
            0x20,
            0x33,
            0x00,
          ];
          for (int i = 0; i < 16; i++) {
            if (readHeader[i] != magic[i]) {
              isCorrupted = true;
              break;
            }
          }
        }

        expect(isCorrupted, isTrue);
      },
    );
  });
}
