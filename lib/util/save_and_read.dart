import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveAndRead {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _geFileFor(String identifier) async {
    final path = await _localPath;
    return File('$path/${identifier}_data.txt');
  }

  static Future<File> writeData({
    required String identifier,
    required String data,
  }) async {
    final file = await _geFileFor(identifier);
    return file.writeAsString(data);
  }

  static Future<String> readData(String identifier) async {
    final file = await _geFileFor(identifier);
    final contents = await file.readAsString();
    return contents;
  }
}
