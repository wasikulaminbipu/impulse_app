import 'dart:io';

void main(List<String> args) {
  double? minCoverage;
  for (final arg in args) {
    if (arg.startsWith('--min-coverage=')) {
      minCoverage = double.tryParse(arg.substring('--min-coverage='.length));
    }
  }

  stdout.writeln(
    '================================================================',
  );
  stdout.writeln(' 📊 Impulse DEX - Code Coverage Badge Generator');
  stdout.writeln(
    '================================================================',
  );

  final lcovFile = File('coverage/lcov.info');
  if (!lcovFile.existsSync()) {
    stderr.writeln(
      '⚠️ Warning: coverage/lcov.info not found! Run "flutter test --coverage" first.',
    );
    exit(0);
  }

  final lines = lcovFile.readAsLinesSync();
  var rawTotalLines = 0;
  var rawCoveredLines = 0;

  var filteredTotalLines = 0;
  var filteredCoveredLines = 0;

  var currentFileIsGenerated = false;

  for (final line in lines) {
    if (line.startsWith('SF:')) {
      final filePath = line.substring(3);
      currentFileIsGenerated =
          filePath.endsWith('.g.dart') ||
          filePath.endsWith('.freezed.dart') ||
          filePath.contains('.drift.') ||
          filePath.contains('/generated/') ||
          filePath.contains('.mocks.dart');
    } else if (line.startsWith('DA:')) {
      rawTotalLines++;
      final parts = line.substring(3).split(',');
      final hitCount = parts.length >= 2 ? (int.tryParse(parts[1]) ?? 0) : 0;
      if (hitCount > 0) {
        rawCoveredLines++;
      }

      if (!currentFileIsGenerated) {
        filteredTotalLines++;
        if (hitCount > 0) {
          filteredCoveredLines++;
        }
      }
    }
  }

  final percentage = filteredTotalLines > 0
      ? (filteredCoveredLines / filteredTotalLines) * 100
      : 0.0;
  final pctFormatted = percentage.toStringAsFixed(1);

  final rawPct = rawTotalLines > 0
      ? ((rawCoveredLines / rawTotalLines) * 100).toStringAsFixed(1)
      : '0.0';

  stdout.writeln(
    '  📊 Raw Total Lines: $rawTotalLines (Covered: $rawCoveredLines - $rawPct%)',
  );
  stdout.writeln(
    '  ✨ High-Signal Domain/Core Lines (Excl. Codegen): $filteredTotalLines (Covered: $filteredCoveredLines - $pctFormatted%)',
  );
  stdout.writeln('  📈 High-Signal Line Coverage: $pctFormatted%');

  // Determine Badge Color
  String badgeColor;
  if (percentage >= 90.0) {
    badgeColor = '#44cc11'; // bright green
  } else if (percentage >= 80.0) {
    badgeColor = '#97ca00'; // green
  } else if (percentage >= 70.0) {
    badgeColor = '#a4a61d'; // yellow green
  } else if (percentage >= 60.0) {
    badgeColor = '#dfb317'; // yellow
  } else {
    badgeColor = '#e05d44'; // red
  }

  final svgContent =
      '''
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="112" height="20" role="img" aria-label="coverage: $pctFormatted%">
  <title>coverage: $pctFormatted%</title>
  <linearGradient id="s" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <clipPath id="r">
    <rect width="112" height="20" rx="3" fill="#fff"/>
  </clipPath>
  <g clip-path="url(#r)">
    <rect width="61" height="20" fill="#555"/>
    <rect x="61" width="51" height="20" fill="$badgeColor"/>
    <rect width="112" height="20" fill="url(#s)"/>
  </g>
  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="110">
    <text aria-hidden="true" x="315" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="510">coverage</text>
    <text x="315" y="140" transform="scale(.1)" fill="#fff" textLength="510">coverage</text>
    <text aria-hidden="true" x="855" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="410">$pctFormatted%</text>
    <text x="855" y="140" transform="scale(.1)" fill="#fff" textLength="410">$pctFormatted%</text>
  </g>
</svg>''';

  final badgesDir = Directory('badges');
  if (!badgesDir.existsSync()) {
    badgesDir.createSync(recursive: true);
  }

  final badgeFile = File('badges/coverage.svg');
  badgeFile.writeAsStringSync(svgContent);
  stdout.writeln('  ✅ SVG Badge Generated: ${badgeFile.path}');

  final githubOutput = Platform.environment['GITHUB_OUTPUT'];
  if (githubOutput != null && githubOutput.isNotEmpty) {
    try {
      final sink = File(githubOutput).openWrite(mode: FileMode.append);
      sink.writeln('coverage_pct=$pctFormatted');
      sink.writeln('covered_lines=$filteredCoveredLines');
      sink.writeln('total_lines=$filteredTotalLines');
      sink.close();
    } catch (_) {}
  }

  stdout.writeln(
    '================================================================\n',
  );

  if (minCoverage != null) {
    if (percentage < minCoverage) {
      stderr.writeln(
        '❌ Coverage Quality Gate Failure: Current coverage $pctFormatted% is below required minimum threshold $minCoverage%!\n',
      );
      exit(1);
    } else {
      stdout.writeln(
        '✅ Coverage Quality Gate Passed: $pctFormatted% >= required minimum $minCoverage%\n',
      );
    }
  }
}
