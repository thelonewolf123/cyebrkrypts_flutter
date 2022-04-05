import 'dart:io';

import 'package:cyberkrypts/log/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class CustomFileHandling {
  Logger logger = Logger('CustomFileHandling');

  CustomFileHandling();

  Future saveFile(String path, String content) async {
    try {
      final file = File(path);
      await file.writeAsString(content);
    } catch (e) {
      logger.logError('Error while saving file: $e');
    }
  }

  Future<String> selectFolder(context) async {
    logger.logDebug('selectFolder');
    final status = await isPermissionAvailable();
    if (status) {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      logger.logDebug(selectedDirectory);
      return selectedDirectory ?? '';
    }
    logger.logError('Permission not available');
    return '';
  }

  Future<String> selectFile(context) async {
    logger.logDebug('selectFile');
    final status = await isPermissionAvailable();
    if (status) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['py'],
      );
      logger.logDebug(result!.files.first.path);
      String? path = result.files.first.path;
      return path ?? '';
    }
    logger.logError('No permission');
    return '';
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
    try {
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      logger.logError('readFile: $e');
      return '';
    }
  }
}
