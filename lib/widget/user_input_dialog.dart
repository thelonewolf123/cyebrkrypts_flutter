import 'package:flutter/material.dart';

class UserInputDialog extends StatefulWidget {
  const UserInputDialog({Key? key}) : super(key: key);

  @override
  State<UserInputDialog> createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  String _stdin = '';
  final String _title = 'Input';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(_title, style: TextStyle(fontSize: 18, color: Colors.grey[800])),
      content: TextField(
        maxLines: null,
        onChanged: (value) {
          _stdin = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter your input here / use new line for multiple inputs',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _stdin),
          child: const Text('OK'),
        )
      ],
    );
  }
}
