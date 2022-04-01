import 'package:cyberkrypts/provider/code_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutputTabWidget extends StatefulWidget {
  const OutputTabWidget({Key? key}) : super(key: key);

  @override
  State<OutputTabWidget> createState() => _OutputTabWidgetState();
}

class _OutputTabWidgetState extends State<OutputTabWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 26, 26, 26),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...context
              .read<CodeProvider>()
              .output
              .map(
                (e) => Text(
                  e,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
