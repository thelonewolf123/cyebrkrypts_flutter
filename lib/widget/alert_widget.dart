import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String discription;
  const AlertWidget({Key? key, required this.title, required this.discription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(discription),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
