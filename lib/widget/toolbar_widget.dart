import 'package:flutter/material.dart';

class ToolBarWidget extends StatelessWidget {
  final Function onKeyPress;
  ToolBarWidget({Key? key, required this.onKeyPress}) : super(key: key);
  final List<String> _keys = [
    'Tab',
    '(',
    ')',
    ':',
    '\\',
    '"',
    '\'',
    ';',
    '.',
    ',',
    '=',
    '+',
    '-',
    '*',
    '/',
    '%',
    '!',
    '>',
    '<',
    '&',
    '|',
    '^',
    '~',
    '?',
    '@',
    '#',
    '\$',
    '{',
    '}',
  ];
  _handleEvent(String value) {
    if (value == 'Tab') {
      onKeyPress('\t');
    } else {
      onKeyPress(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.black87,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _keys.map((key) {
            return TextButton(
                onPressed: () => _handleEvent(key), child: Text(key));
          }).toList(),
        ),
      ),
    );
  }
}
