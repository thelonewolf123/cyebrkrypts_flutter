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
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 26, 26, 26),
        ),
        height: double.infinity,
        child: Column(
          children: [
            ...context
                .read<CodeProvider>()
                .output
                .map(
                  (e) => Text(
                    e,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
