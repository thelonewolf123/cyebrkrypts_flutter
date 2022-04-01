import 'package:cyberkrypts/common/python_interpreter.dart';
import 'package:cyberkrypts/provider/code_provider.dart';
import 'package:cyberkrypts/widget/code_editor.dart';
import 'package:cyberkrypts/widget/monaco_editor.dart';
import 'package:cyberkrypts/widget/output_tab.dart';
import 'package:cyberkrypts/widget/user_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({Key? key}) : super(key: key);

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen>
    with TickerProviderStateMixin {
  _runCode() async {
    // show result as alert
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const UserInputDialog();
      },
    );

    String code = context.read<CodeProvider>().code;
    String stdin = context.read<CodeProvider>().stdin;

    var output = await PythonInterpreter.runPythonCode(code, stdin, []);

    if (output.run['stderr'] != null) {
      context.read<CodeProvider>().output.add(output.run['stderr']);
    } else {
      context.read<CodeProvider>().setOutput(output.run['output']);
      print(output.run['output']);
    }
    _tabController.animateTo(1);
  }

  late TabController _tabController;

  _handleClick(int value) {
    switch (value) {
      case 0:
        print('Open');
        break;
      case 1:
        print('Save');
        break;
      case 2:
        print('Save as');
        break;
      case 3:
        print('Font size');
        break;
      case 4:
        print('Default template');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: Text(context.read<CodeProvider>().fileName),
          backgroundColor: Colors.green,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Code',
              ),
              Tab(
                text: 'Output',
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            PopupMenuButton<int>(
              onSelected: (item) => _handleClick(item),
              itemBuilder: (context) => const [
                PopupMenuItem<int>(value: 0, child: Text('Open')),
                PopupMenuItem<int>(value: 1, child: Text('Save')),
                PopupMenuItem<int>(value: 2, child: Text('Save as')),
                PopupMenuDivider(),
                PopupMenuItem<int>(value: 3, child: Text('Font size')),
                PopupMenuItem<int>(value: 4, child: Text('Default template')),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        // CodeEditorWidget(
        //   onRun: _runCode,
        // ),
        MonacoEdiot(),
        const OutputTabWidget()
      ]),
    );
  }
}
