import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'event_info.dart';

class SaveAndRead {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath; //calls get _localPath
    return File('$path/data.txt');
  }

  static Future<File> writeData(String data) async {
    final file = await _localFile; //calls get _localFile
    return file.writeAsString('$data');
  }

  static Future<String> readData() async {
    try{
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}