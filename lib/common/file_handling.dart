import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class CustomFileHandling {
  CustomFileHandling();

  Future saveFile(String path, String content) async {
    print('saveFile: $path, $content');
    final file = File(path);
    await file.writeAsString(content);
  }

  Future selectFolder(context) async {
    print('selectFolder');
    final status = await isPermissionAvailable();
    if (status) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      print(selectedDirectory);
    }
  }

  Future isPermissionAvailable() async {
    bool status = false;
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
        status = await Permission.storage.isGranted;
        if (!status) await Permission.storage.request();
        status = await Permission.storage.isGranted;
      }
    }
    return status;
  }

  Future<String> readFile(String filePath) async {
    File file = File(filePath); // 1
    String fileContent = await file.readAsString(); // 2
    print('File Content: $fileContent');
    return fileContent;
  }
}
