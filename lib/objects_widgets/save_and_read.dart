import 'dart:io';
import 'dart:convert';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:path_provider/path_provider.dart';

class SaveAndRead {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath; //calls get _localPath
    return File('$path/data.txt');
  }

  Future<File> writeData(String data) async {
    final file = await _localFile; //calls get _localFile
    return file.writeAsString('$data');
  }

  Future<String> readData() async {
    try{
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}