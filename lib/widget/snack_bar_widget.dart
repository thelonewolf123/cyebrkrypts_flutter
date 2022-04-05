import 'package:flutter/material.dart';

class SnackBarWidget {
  static void showSnakBar(BuildContext context, String message) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
