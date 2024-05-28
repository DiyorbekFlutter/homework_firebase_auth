import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  static late Directory _directory;
  static late File _file;

  static Future<String> get getLocation async {
    _directory = await getApplicationDocumentsDirectory();
    return _directory.path;
  }

  static String readFile(String path) => File(path).readAsStringSync();

  static Future<void> put(String path) async {
    final String applicationDocumentsDirectory = await getLocation;
    _file = File("$applicationDocumentsDirectory/profile_image.txt");
    await _file.writeAsString(path);
  }
}
