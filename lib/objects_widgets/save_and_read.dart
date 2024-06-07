import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveAndRead {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  static Future<File> writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

  static Future<String> readData() async {
    final file = await _localFile;
    final contents = await file.readAsString();
    return contents;
  }
}

