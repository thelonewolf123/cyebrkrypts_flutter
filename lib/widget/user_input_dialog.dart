import 'package:flutter/material.dart';

class UserInputDialog extends StatefulWidget {
  final String title;
  final String hint;
  const UserInputDialog({Key? key, required this.title, required this.hint})
      : super(key: key);

  @override
  State<UserInputDialog> createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  String _stdin = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title,
          style: TextStyle(fontSize: 18, color: Colors.grey[800])),
      content: TextField(
        maxLines: null,
        onChanged: (value) {
          _stdin = value;
        },
        decoration: InputDecoration(
          hintText: widget.hint,
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
