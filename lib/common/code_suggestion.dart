import 'package:flutter/material.dart';

class PythonCodeSuggestion {
  late TextEditingController _controller;
  PythonCodeSuggestion(TextEditingController controller) {
    _controller = controller;
  }

  void onTextChange(String code) {
    print(code);
  }
}
