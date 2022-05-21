import 'package:flutter/material.dart';

class CodeProvider with ChangeNotifier {
  String _code = '';
  String _fileName = 'Untitled';
  String _filePath = '';
  List<String> _output = [];

  String get code => _code;

  String get fileName => _fileName;

  String get filePath => _filePath;

  List<String> get output => _output;

  void setFileName(String value) {
    _fileName = value;
    notifyListeners();
  }

  void setCode(String? text) {
    _code = text!;
    notifyListeners();
  }

  void setFilePath(String value) {
    _filePath = value;
    notifyListeners();
  }

  void setOutput(List<String> value) {
    _output = value;
    notifyListeners();
  }
}
