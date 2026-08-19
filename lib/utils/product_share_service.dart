import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductShareService {
  /// Captures the widget attached to [repaintBoundaryKey] as a PNG image,
  /// saves it to temp storage asynchronously, and opens the native share sheet.
  static Future<void> shareProductCard({
    required GlobalKey repaintBoundaryKey,
    required String shareTitle,
    String? shareSubject,
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary = repaintBoundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Unable to locate render boundary for sharing');
      }

      // Check if boundary is still painting or attached
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
      }

      // Capture image with given pixel ratio (defaults to high resolution 3.0)
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to generate image byte data');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Write file in temporary directory
      final tempDir = await getTemporaryDirectory();
      final String fileName =
          'product_share_${DateTime.now().millisecondsSinceEpoch}.png';
      final File imgFile = File('${tempDir.path}/$fileName');
      await imgFile.writeAsBytes(pngBytes, flush: true);

      // Invoke native share sheet
      final XFile xFile = XFile(imgFile.path, mimeType: 'image/png');
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [xFile],
        text: shareTitle,
        subject: shareSubject ?? shareTitle,
      );
    } catch (e) {
      debugPrint('Error sharing product screenshot: $e');
      rethrow;
    }
  }
}
