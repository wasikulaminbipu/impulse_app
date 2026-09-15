import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:impulse_app/config/app_config.dart';
import 'package:impulse_app/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

/// Utility service that handles capturing widget boundaries as images or
/// generating native vector/text PDF documents and presenting platform share sheets.
class ProductShareService {
  /// Loads any image asset (WebP, PNG, JPEG) and converts it to PNG byte data
  /// for universal compatibility with PDF document renderers.
  static Future<Uint8List?> loadAssetImageAsPng(String assetPath) async {
    try {
      String path = assetPath.trim();
      if (!path.startsWith('assets/')) {
        path = 'assets/$path';
      }
      final ByteData data = await rootBundle.load(path);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? pngByteData = await fi.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      return pngByteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  /// Captures the widget attached to [repaintBoundaryKey] as a PNG image,
  /// saves it to temp storage asynchronously, and opens the native share sheet.
  static Future<void> shareProductCard({
    required GlobalKey repaintBoundaryKey,
    required String shareTitle,
    String? shareSubject,
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary =
          repaintBoundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Unable to locate render boundary for sharing');
      }

      // Check if boundary is still painting or attached
      if (boundary.debugNeedsPaint) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }

      // Capture image with given pixel ratio (defaults to high resolution 3.0)
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

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
      Rect? sharePositionOrigin;
      try {
        if (boundary.hasSize &&
            boundary.size.width > 0 &&
            boundary.size.height > 0) {
          sharePositionOrigin =
              boundary.localToGlobal(Offset.zero) & boundary.size;
        }
      } catch (_) {
        // Fall back to null if layout coordinates cannot be computed
      }

      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: shareTitle,
          subject: shareSubject ?? shareTitle,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
    } catch (e) {
      debugPrint('Error sharing product screenshot: $e');
      rethrow;
    }
  }

  /// Builds a native vector/text PDF document for [product].
  ///
  /// Includes header with `logo_impulse.png`, product photo, clinical monograph
  /// tables, species-specific dosing, precautions callouts, presentation tables,
  /// two-column Manufacturer & Distributor section, and Google Play app download QR code.
  static Future<Uint8List> buildNativeProductPdf({
    required Product product,
    Uint8List? logoBytes,
    Uint8List? productImageBytes,
    Uint8List? manufacturerLogoBytes,
    List<Species>? speciesList,
  }) async {
    // 1. Attempt to load logo from assets if not provided
    Uint8List? effectiveLogoBytes = logoBytes;
    effectiveLogoBytes ??= await loadAssetImageAsPng(
      'assets/images/logo_impulse.png',
    );

    // 2. Attempt to load product image from assets if not provided
    Uint8List? effectiveProductImageBytes = productImageBytes;
    if (effectiveProductImageBytes == null &&
        product.imageUrl != null &&
        product.imageUrl!.trim().isNotEmpty) {
      String path = product.imageUrl!.trim();
      if (!path.startsWith('assets/')) {
        path = path.startsWith('product_image/')
            ? 'assets/$path'
            : 'assets/product_image/$path';
      }
      effectiveProductImageBytes = await loadAssetImageAsPng(path);
    }

    // 3. Attempt to load manufacturer logo from assets if not provided
    Uint8List? effectiveManufacturerLogoBytes = manufacturerLogoBytes;
    if (effectiveManufacturerLogoBytes == null &&
        product.manufacturer.logoUrl != null &&
        product.manufacturer.logoUrl!.trim().isNotEmpty) {
      final path =
          'assets/manufacturers_logo/${product.manufacturer.logoUrl!.trim()}';
      effectiveManufacturerLogoBytes = await loadAssetImageAsPng(path);
    }

    // 4. Attempt to load Inter TTF fonts for clean typography
    pw.Font? ttfRegular;
    pw.Font? ttfBold;
    try {
      final fontRegData = await rootBundle.load(
        'assets/fonts/Inter-Regular.ttf',
      );
      final fontBoldData = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
      ttfRegular = pw.Font.ttf(fontRegData);
      ttfBold = pw.Font.ttf(fontBoldData);
    } catch (_) {
      // Use built-in Helvetica if font assets are inaccessible
    }

    final theme = pw.ThemeData.withFont(
      base: ttfRegular ?? pw.Font.helvetica(),
      bold: ttfBold ?? pw.Font.helveticaBold(),
    );

    final pdf = pw.Document(
      title: '${product.titleEn} - Technical Datasheet',
      author: 'Impulse AgriScience Ltd.',
      creator: 'Impulse Mobile App',
      theme: theme,
    );

    // Styling Colors
    final primaryColor = PdfColor.fromHex('#0F763E'); // Official Impulse Green
    final accentGreen = PdfColor.fromHex('#25D366');
    final slateDark = PdfColor.fromHex('#0F172A');
    final slateBody = PdfColor.fromHex('#334155');
    final slateLight = PdfColor.fromHex('#64748B');
    final borderLight = PdfColor.fromHex('#CBD5E1');
    final tableHeaderBg = PdfColor.fromHex('#F1F5F9');
    final tableZebraBg = PdfColor.fromHex('#F8FAFC');

    pw.Widget buildSectionTitle(String title) {
      return pw.Container(
        width: double.infinity,
        margin: const pw.EdgeInsets.only(top: 11, bottom: 5),
        padding: const pw.EdgeInsets.only(bottom: 2.5),
        decoration: pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(color: primaryColor, width: 1.2),
          ),
        ),
        child: pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: primaryColor,
            letterSpacing: 0.6,
          ),
        ),
      );
    }

    pw.Widget buildFormalListItem({
      required pw.Widget content,
      double bottomPadding = 3.0,
      PdfColor? bulletColor,
      double bulletSize = 3.5,
      double bulletTopMargin = 3.2,
      double indent = 12.0,
    }) {
      return pw.Padding(
        padding: pw.EdgeInsets.only(bottom: bottomPadding),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: indent,
              alignment: pw.Alignment.topLeft,
              child: pw.Container(
                width: bulletSize,
                height: bulletSize,
                margin: pw.EdgeInsets.only(top: bulletTopMargin),
                decoration: pw.BoxDecoration(
                  color: bulletColor ?? primaryColor,
                  shape: pw.BoxShape.circle,
                ),
              ),
            ),
            pw.Expanded(child: content),
          ],
        ),
      );
    }

    final logoImage = effectiveLogoBytes != null
        ? pw.MemoryImage(effectiveLogoBytes)
        : null;
    final productImage = effectiveProductImageBytes != null
        ? pw.MemoryImage(effectiveProductImageBytes)
        : null;
    final manufacturerLogo = effectiveManufacturerLogoBytes != null
        ? pw.MemoryImage(effectiveManufacturerLogoBytes)
        : null;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  if (logoImage != null)
                    pw.Image(logoImage, height: 38)
                  else
                    pw.Text(
                      'IMPULSE AGRISCIENCE',
                      style: pw.TextStyle(
                        color: primaryColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'PRODUCT TECHNICAL DATASHEET',
                        style: pw.TextStyle(
                          color: slateDark,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8.5,
                          letterSpacing: 0.8,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        'Official Product Specification Monograph',
                        style: pw.TextStyle(color: slateLight, fontSize: 7.5),
                      ),
                      pw.SizedBox(height: 1.5),
                      pw.Text(
                        'Product Management Department',
                        style: pw.TextStyle(
                          color: primaryColor,
                          fontSize: 7.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                height: 2,
                margin: const pw.EdgeInsets.only(top: 8, bottom: 10),
                color: primaryColor,
              ),
            ],
          );
        },
        footer: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 10),
            padding: const pw.EdgeInsets.only(top: 6),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: borderLight, width: 0.6),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Impulse AgriScience Ltd. • Product Monograph',
                  style: pw.TextStyle(fontSize: 7.5, color: slateLight),
                ),
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.TextStyle(fontSize: 7.5, color: slateLight),
                ),
              ],
            ),
          );
        },
        build: (pw.Context context) {
          return [
            // Product Hero Header Card
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: tableZebraBg,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: borderLight, width: 0.8),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (product.category.nameEn.isNotEmpty) ...[
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('#E8F8F0'),
                              borderRadius: pw.BorderRadius.circular(3),
                              border: pw.Border.all(
                                color: accentGreen,
                                width: 0.6,
                              ),
                            ),
                            child: pw.Text(
                              product.category.nameEn.toUpperCase(),
                              style: pw.TextStyle(
                                color: primaryColor,
                                fontSize: 7.5,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                        ],
                        pw.Text(
                          product.titleEn,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: slateDark,
                          ),
                        ),
                        if (product.mottoEn != null &&
                            product.mottoEn!.trim().isNotEmpty) ...[
                          pw.SizedBox(height: 3),
                          pw.Text(
                            product.mottoEn!,
                            textAlign: pw.TextAlign.justify,
                            style: pw.TextStyle(
                              fontSize: 9.5,
                              fontStyle: ttfRegular != null
                                  ? pw.FontStyle.italic
                                  : pw.FontStyle.normal,
                              color: primaryColor,
                            ),
                          ),
                        ],
                        if (product.shortDescriptionEn != null &&
                            product.shortDescriptionEn!.trim().isNotEmpty) ...[
                          pw.SizedBox(height: 5),
                          pw.Text(
                            product.shortDescriptionEn!,
                            textAlign: pw.TextAlign.justify,
                            style: pw.TextStyle(
                              fontSize: 9,
                              color: slateBody,
                              lineSpacing: 1.25,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (productImage != null) ...[
                    pw.SizedBox(width: 12),
                    pw.Container(
                      width: 80,
                      height: 80,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(4),
                        border: pw.Border.all(color: borderLight, width: 0.8),
                      ),
                      child: pw.Center(child: pw.Image(productImage)),
                    ),
                  ],
                ],
              ),
            ),

            // Compositions Table
            if (product.compositions.isNotEmpty) ...[
              buildSectionTitle('COMPOSITION'),
              pw.TableHelper.fromTextArray(
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(2),
                },
                headerStyle: pw.TextStyle(
                  fontSize: 8.5,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
                headerDecoration: pw.BoxDecoration(color: tableHeaderBg),
                cellStyle: pw.TextStyle(fontSize: 8, color: slateBody),
                cellPadding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3.5,
                ),
                headers: ['Active Ingredient', 'Concentration'],
                data: product.compositions
                    .map((c) => [c.ingredientEn, c.concentration])
                    .toList(),
                border: pw.TableBorder.all(color: borderLight, width: 0.5),
              ),
              if (product.compositionBasisEn != null &&
                  product.compositionBasisEn!.trim().isNotEmpty) ...[
                pw.SizedBox(height: 3),
                pw.Text(
                  '* Basis: ${product.compositionBasisEn}',
                  style: pw.TextStyle(fontSize: 7.5, color: slateLight),
                ),
              ],
            ],

            // Indications
            if (product.indications.isNotEmpty) ...[
              buildSectionTitle('INDICATIONS'),
              ...product.indications.map(
                (ind) => buildFormalListItem(
                  content: pw.Text(
                    ind.textEn,
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: 8.5,
                      color: slateBody,
                      lineSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],

            // Dosage & Administration (Species-Specific)
            if (product.directions.isNotEmpty) ...[
              buildSectionTitle('DOSAGE & ADMINISTRATION'),
              ...product.directions.map((dir) {
                final spec = speciesList?.firstWhere(
                  (s) => s.id == dir.speciesId,
                  orElse: () =>
                      const Species(id: 0, targetGroupId: 0, nameEn: ''),
                );
                final specName = (spec != null && spec.nameEn.trim().isNotEmpty)
                    ? spec.nameEn.trim()
                    : null;
                final dosageVal = dir.dosageEn ?? '';
                final displayDosage = (specName != null && specName.isNotEmpty)
                    ? '$specName: $dosageVal'
                    : dosageVal;

                return buildFormalListItem(
                  bottomPadding: 4.5,
                  content: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (displayDosage.isNotEmpty)
                        pw.RichText(
                          textAlign: pw.TextAlign.justify,
                          text: pw.TextSpan(
                            style: const pw.TextStyle(
                              fontSize: 8.5,
                              lineSpacing: 1.2,
                            ),
                            children: [
                              if (specName != null && specName.isNotEmpty) ...[
                                pw.TextSpan(
                                  text: '$specName: ',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: slateDark,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: dosageVal,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.normal,
                                    color: slateBody,
                                  ),
                                ),
                              ] else ...[
                                pw.TextSpan(
                                  text: displayDosage,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: slateDark,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      if (dir.administrationEn != null &&
                          dir.administrationEn!.trim().isNotEmpty) ...[
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2),
                          child: pw.RichText(
                            textAlign: pw.TextAlign.justify,
                            text: pw.TextSpan(
                              style: pw.TextStyle(
                                fontSize: 8,
                                color: slateBody,
                                lineSpacing: 1.2,
                              ),
                              children: [
                                pw.TextSpan(
                                  text: 'Administration: ',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: slateDark,
                                  ),
                                ),
                                pw.TextSpan(text: dir.administrationEn!.trim()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],

            // Benefits
            if (product.benefits.isNotEmpty) ...[
              buildSectionTitle('KEY BENEFITS'),
              ...product.benefits.map(
                (ben) => buildFormalListItem(
                  content: pw.Text(
                    ben.textEn,
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: 8.5,
                      color: slateBody,
                      lineSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],

            // Precautions & Warnings
            if (product.precautions.isNotEmpty) ...[
              buildSectionTitle('PRECAUTIONS & WARNINGS'),
              pw.Container(
                padding: const pw.EdgeInsets.all(7),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFFBEB'),
                  borderRadius: pw.BorderRadius.circular(4),
                  border: pw.Border.all(
                    color: PdfColor.fromHex('#FCD34D'),
                    width: 0.6,
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: product.precautions
                      .map(
                        (p) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 2.5),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                width: 14,
                                margin: const pw.EdgeInsets.only(top: 0.5),
                                child: pw.Text(
                                  '⚠',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    color: PdfColor.fromHex('#B45309'),
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Text(
                                  p.textEn,
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    color: PdfColor.fromHex('#92400E'),
                                    lineSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],

            // Presentations & Pricing
            if (product.presentations.isNotEmpty) ...[
              buildSectionTitle('PRESENTATION & PACK SIZES'),
              pw.TableHelper.fromTextArray(
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(2),
                },
                headerStyle: pw.TextStyle(
                  fontSize: 8.5,
                  fontWeight: pw.FontWeight.bold,
                  color: primaryColor,
                ),
                headerDecoration: pw.BoxDecoration(color: tableHeaderBg),
                cellStyle: pw.TextStyle(fontSize: 8, color: slateBody),
                cellPadding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                headers: ['Pack Size', 'Maximum Retail Price (MRP)'],
                data: product.presentations.map((p) {
                  final priceText = (p.mrp != null && p.mrp! > 0)
                      ? 'BDT ${p.mrp!.toStringAsFixed(2)}'
                      : 'Call for Price';
                  return [p.size, priceText];
                }).toList(),
                border: pw.TableBorder.all(color: borderLight, width: 0.5),
              ),
            ],

            // Manufacturer & Distributor (Two-Column Layout: Not Table)
            buildSectionTitle('MANUFACTURER & DISTRIBUTOR'),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left Column: Manufactured By
                  pw.Expanded(
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        color: tableZebraBg,
                        borderRadius: pw.BorderRadius.circular(6),
                        border: pw.Border.all(color: borderLight, width: 0.6),
                      ),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // One side: ONLY Logo
                          if (manufacturerLogo != null)
                            pw.Container(
                              width: 50,
                              height: 50,
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.all(3),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(
                                  color: borderLight,
                                  width: 0.5,
                                ),
                              ),
                              child: pw.Image(manufacturerLogo),
                            )
                          else
                            pw.Container(
                              width: 50,
                              height: 50,
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.all(3),
                              decoration: pw.BoxDecoration(
                                color: tableHeaderBg,
                                borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(
                                  color: borderLight,
                                  width: 0.5,
                                ),
                              ),
                              child: pw.Text(
                                'MFG',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  color: slateLight,
                                ),
                              ),
                            ),
                          pw.SizedBox(width: 8),
                          // Other side: ALL the text
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Manufactured By',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                    color: primaryColor,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  product.manufacturer.nameEn.isNotEmpty
                                      ? product.manufacturer.nameEn
                                      : 'Not Specified',
                                  style: pw.TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: pw.FontWeight.bold,
                                    color: slateDark,
                                  ),
                                ),
                                if (product.manufacturer.addressEn != null &&
                                    product
                                        .manufacturer
                                        .addressEn!
                                        .isNotEmpty) ...[
                                  pw.SizedBox(height: 2.5),
                                  pw.Text(
                                    product.manufacturer.addressEn!,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                      lineSpacing: 1.15,
                                    ),
                                  ),
                                ],
                                if (product.manufacturer.mobile != null &&
                                    product
                                        .manufacturer
                                        .mobile!
                                        .isNotEmpty) ...[
                                  pw.SizedBox(height: 2),
                                  pw.Text(
                                    'Phone: ${product.manufacturer.mobile!}',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                    ),
                                  ),
                                ],
                                if (product.manufacturer.email != null &&
                                    product.manufacturer.email!.isNotEmpty) ...[
                                  pw.SizedBox(height: 1.5),
                                  pw.Text(
                                    'Email: ${product.manufacturer.email!}',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                    ),
                                  ),
                                ],
                                if (product.manufacturer.website != null &&
                                    product
                                        .manufacturer
                                        .website!
                                        .isNotEmpty) ...[
                                  pw.SizedBox(height: 1.5),
                                  pw.Text(
                                    'Web: ${product.manufacturer.website!}',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  pw.SizedBox(width: 10),

                  // Right Column: Marketed and Distributed by
                  pw.Expanded(
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        color: tableZebraBg,
                        borderRadius: pw.BorderRadius.circular(6),
                        border: pw.Border.all(color: borderLight, width: 0.6),
                      ),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // One side: ONLY Logo
                          if (logoImage != null)
                            pw.Container(
                              width: 50,
                              height: 50,
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.all(3),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(
                                  color: borderLight,
                                  width: 0.5,
                                ),
                              ),
                              child: pw.Image(logoImage),
                            )
                          else
                            pw.Container(
                              width: 50,
                              height: 50,
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.all(3),
                              decoration: pw.BoxDecoration(
                                color: tableHeaderBg,
                                borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(
                                  color: borderLight,
                                  width: 0.5,
                                ),
                              ),
                              child: pw.Text(
                                'IMPULSE',
                                style: pw.TextStyle(
                                  fontSize: 7.5,
                                  fontWeight: pw.FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          pw.SizedBox(width: 8),
                          // Other side: ALL the text
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Marketed and Distributed by',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                    color: primaryColor,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  AppConfig.companyName,
                                  style: pw.TextStyle(
                                    fontSize: 8.5,
                                    fontWeight: pw.FontWeight.bold,
                                    color: slateDark,
                                  ),
                                ),
                                pw.SizedBox(height: 2.5),
                                pw.Text(
                                  AppConfig.companyAddress,
                                  style: pw.TextStyle(
                                    fontSize: 7,
                                    color: slateBody,
                                    lineSpacing: 1.15,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  'Phone: ${AppConfig.supportPhone}',
                                  style: pw.TextStyle(
                                    fontSize: 7,
                                    color: slateBody,
                                  ),
                                ),
                                if (AppConfig.supportEmail.isNotEmpty) ...[
                                  pw.SizedBox(height: 1.5),
                                  pw.Text(
                                    'Email: ${AppConfig.supportEmail}',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                    ),
                                  ),
                                ],
                                if (AppConfig.websiteCleanUrl.isNotEmpty) ...[
                                  pw.SizedBox(height: 1.5),
                                  pw.Text(
                                    'Web: ${AppConfig.websiteCleanUrl}',
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: slateBody,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // App Download & Play Store QR Code
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 14),
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: tableZebraBg,
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: borderLight, width: 0.7),
              ),
              child: pw.Row(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(4),
                      border: pw.Border.all(color: borderLight, width: 0.5),
                    ),
                    child: pw.BarcodeWidget(
                      barcode: pw.Barcode.qrCode(),
                      data: AppConfig.playStoreUrl,
                      width: 52,
                      height: 52,
                      drawText: false,
                    ),
                  ),
                  pw.SizedBox(width: 14),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'DOWNLOAD IMPULSE APP ON GOOGLE PLAY',
                          style: pw.TextStyle(
                            fontSize: 8.5,
                            fontWeight: pw.FontWeight.bold,
                            color: primaryColor,
                            letterSpacing: 0.4,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'Search "Impulse AgriScience" on Google Play Store or scan this QR code to download the complete veterinary and aquaculture product directory.',
                          textAlign: pw.TextAlign.justify,
                          style: pw.TextStyle(
                            fontSize: 7.5,
                            color: slateBody,
                            lineSpacing: 1.15,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          'App ID: ${AppConfig.playStorePackageName}',
                          style: pw.TextStyle(fontSize: 6.8, color: slateLight),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  /// Builds and exports a native vector/text PDF document for [product],
  /// then invokes the native share sheet.
  static Future<void> shareProductPdf({
    required Product product,
    String? shareSubject,
    Uint8List? logoBytes,
    Uint8List? productImageBytes,
    Uint8List? manufacturerLogoBytes,
    List<Species>? speciesList,
  }) async {
    try {
      final Uint8List pdfBytes = await buildNativeProductPdf(
        product: product,
        logoBytes: logoBytes,
        productImageBytes: productImageBytes,
        manufacturerLogoBytes: manufacturerLogoBytes,
        speciesList: speciesList,
      );

      final tempDir = await getTemporaryDirectory();
      final sanitizedTitle = product.titleEn
          .replaceAll(RegExp(r'[^\w\s\-]'), '')
          .trim()
          .replaceAll(RegExp(r'\s+'), '_');
      final String fileName = sanitizedTitle.isNotEmpty
          ? '${sanitizedTitle}_${DateTime.now().millisecondsSinceEpoch}.pdf'
          : 'product_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final File pdfFile = File('${tempDir.path}/$fileName');
      await pdfFile.writeAsBytes(pdfBytes, flush: true);

      final XFile xFile = XFile(pdfFile.path, mimeType: 'application/pdf');
      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: product.titleEn,
          subject: shareSubject ?? product.titleEn,
        ),
      );
    } catch (e) {
      debugPrint('Error sharing product PDF: $e');
      rethrow;
    }
  }

  /// Legacy helper for building PDF bytes from raster images if required.
  static Future<Uint8List> buildPdfFromImageBytes({
    required Uint8List imageBytes,
    required int imageWidth,
    required int imageHeight,
    required String title,
    String? author = 'Impulse AgriScience',
  }) async {
    final pdf = pw.Document(
      title: title,
      author: author,
      creator: 'Impulse Mobile App',
    );

    final pdfImage = pw.MemoryImage(imageBytes);
    final double contentWidth = PdfPageFormat.a4.width - 40;
    final double aspectRatio = imageWidth > 0 && imageHeight > 0
        ? imageWidth / imageHeight
        : 1.0;
    final double scaledHeight = contentWidth / aspectRatio;
    final double pageHeight = math.max(
      PdfPageFormat.a4.height,
      scaledHeight + 40,
    );
    final pageFormat = PdfPageFormat(
      PdfPageFormat.a4.width,
      pageHeight,
      marginAll: 20,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfImage));
        },
      ),
    );

    return pdf.save();
  }
}
