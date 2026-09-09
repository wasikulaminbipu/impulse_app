import 'dart:async';
import 'dart:convert';
import 'dart:io';

const int defaultPort = 4040;

void main(List<String> args) async {
  stdout.writeln('====================================================');
  stdout.writeln(' 🚀 Impulse DEX — Data Entry Local Companion Server');
  stdout.writeln('====================================================');

  final dbDir = Directory('assets/db');
  final htmlFile = File('tools/impulse-data-entry.html');

  if (!htmlFile.existsSync()) {
    stderr.writeln('❌ Error: tools/impulse-data-entry.html not found!');
    exit(1);
  }

  if (!dbDir.existsSync()) {
    dbDir.createSync(recursive: true);
  }

  HttpServer? server;
  var port = defaultPort;
  while (server == null && port < defaultPort + 20) {
    try {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    } catch (_) {
      port++;
    }
  }

  if (server == null) {
    stderr.writeln(
      '❌ Error: Could not bind to any port in range $defaultPort-${defaultPort + 20}',
    );
    exit(1);
  }

  final serverUrl = 'http://localhost:${server.port}';
  stdout.writeln('  🌐 Server running at: $serverUrl');
  stdout.writeln('  📁 Database directory: ${dbDir.path}');
  stdout.writeln('  💾 Direct disk saving: ENABLED (assets/db/)');
  stdout.writeln('  🔒 Auto-backup enabled: *.db.bak');
  stdout.writeln('----------------------------------------------------');
  stdout.writeln('  Opening browser automatically...');
  stdout.writeln('  Press Ctrl+C to stop the server.\n');

  _openBrowser(serverUrl);

  await for (final HttpRequest req in server) {
    unawaited(_handleRequest(req, htmlFile, dbDir));
  }
}

Future<void> _handleRequest(
  HttpRequest req,
  File htmlFile,
  Directory dbDir,
) async {
  final res = req.response;

  // CORS headers
  res.headers.add('Access-Control-Allow-Origin', '*');
  res.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers', '*');

  if (req.method == 'OPTIONS') {
    res.statusCode = HttpStatus.ok;
    await res.close();
    return;
  }

  final path = req.uri.path;

  try {
    if (path == '/' ||
        path == '/index.html' ||
        path == '/tools/impulse-data-entry.html') {
      res.headers.contentType = ContentType.html;
      final bytes = await htmlFile.readAsBytes();
      res.add(bytes);
      await res.close();
      return;
    }

    if (path == '/api/status') {
      res.headers.contentType = ContentType.json;
      res.write(
        jsonEncode({
          'ok': true,
          'version': '1.0.0',
          'dbDir': dbDir.path,
          'time': DateTime.now().toIso8601String(),
        }),
      );
      await res.close();
      return;
    }

    if (path == '/api/list') {
      res.headers.contentType = ContentType.json;
      final files = dbDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.db'))
          .map((f) => f.uri.pathSegments.last)
          .toList();
      files.sort();
      res.write(jsonEncode({'ok': true, 'databases': files}));
      await res.close();
      return;
    }

    if (path == '/api/load') {
      final name = req.uri.queryParameters['name'];
      if (name == null ||
          name.isEmpty ||
          name.contains('..') ||
          name.contains('/') ||
          name.contains(r'\')) {
        res.statusCode = HttpStatus.badRequest;
        res.write('Invalid database name');
        await res.close();
        return;
      }
      final targetFile = File('${dbDir.path}/$name');
      if (!targetFile.existsSync()) {
        res.statusCode = HttpStatus.notFound;
        res.write('Database file not found: $name');
        await res.close();
        return;
      }
      res.headers.contentType = ContentType('application', 'octet-stream');
      final bytes = await targetFile.readAsBytes();
      res.add(bytes);
      await res.close();
      return;
    }

    if (path == '/api/save' && req.method == 'POST') {
      final name = req.uri.queryParameters['name'];
      if (name == null ||
          name.isEmpty ||
          name.contains('..') ||
          name.contains('/') ||
          name.contains(r'\')) {
        res.statusCode = HttpStatus.badRequest;
        res.write('Invalid database name');
        await res.close();
        return;
      }
      final targetFile = File('${dbDir.path}/$name');

      final bodyBytes = <int>[];
      await for (final chunk in req) {
        bodyBytes.addAll(chunk);
      }

      if (bodyBytes.isEmpty) {
        res.statusCode = HttpStatus.badRequest;
        res.write('Empty payload');
        await res.close();
        return;
      }

      // Create backup before overwriting
      if (targetFile.existsSync()) {
        final backupFile = File('${dbDir.path}/$name.bak');
        await targetFile.copy(backupFile.path);
      }

      // Write atomically via temporary file
      final tempFile = File('${dbDir.path}/$name.tmp');
      await tempFile.writeAsBytes(bodyBytes, flush: true);
      if (targetFile.existsSync()) {
        await targetFile.delete();
      }
      await tempFile.rename(targetFile.path);

      stdout.writeln(
        '  💾 [SAVED DIRECTLY] ${targetFile.path} (${bodyBytes.length} bytes)',
      );

      res.headers.contentType = ContentType.json;
      res.write(
        jsonEncode({
          'ok': true,
          'message': 'Successfully saved directly to ${targetFile.path}',
          'bytes': bodyBytes.length,
          'backup': '${targetFile.path}.bak',
        }),
      );
      await res.close();
      return;
    }

    res.statusCode = HttpStatus.notFound;
    res.write('Not found');
    await res.close();
  } catch (e, st) {
    stderr.writeln('Request error on $path: $e\n$st');
    try {
      res.statusCode = HttpStatus.internalServerError;
      res.write('Internal server error: $e');
      await res.close();
    } catch (_) {}
  }
}

void _openBrowser(String url) {
  try {
    if (Platform.isWindows) {
      Process.run('cmd', ['/c', 'start', '', url]);
    } else if (Platform.isMacOS) {
      Process.run('open', [url]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [url]);
    }
  } catch (e) {
    stdout.writeln(
      '  Could not auto-open browser: $e. Please navigate to $url manually.',
    );
  }
}
