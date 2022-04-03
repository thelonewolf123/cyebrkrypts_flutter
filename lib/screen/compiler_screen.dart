import 'package:cyberkrypts/common/file_handling.dart';
import 'package:cyberkrypts/common/python_interpreter.dart';
import 'package:cyberkrypts/log/logger.dart';
import 'package:cyberkrypts/provider/code_provider.dart';
// import 'package:cyberkrypts/widget/code_editor.dart';
import 'package:cyberkrypts/widget/code_mirror_widget.dart';
import 'package:cyberkrypts/widget/output_tab.dart';
import 'package:cyberkrypts/widget/user_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({Key? key}) : super(key: key);

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen>
    with TickerProviderStateMixin {
  Logger logger = Logger('CompilerScreen');

  _runCode() async {
    // show result as alert
    String stdin = await _showDialogBox(
      'Input',
      'Enter your input here / use new line for multiple inputs',
    );
    context.read<CodeProvider>().setStdin(stdin);
    String code = context.read<CodeProvider>().code;
    // String stdin = context.read<CodeProvider>().stdin;

    var output = await PythonInterpreter.runPythonCode(code, stdin, []);
    logger.logDebug(output.stdout);

    if (output.stderr.isNotEmpty) {
      context.read<CodeProvider>().setOutput(output.stderr.split('\n'));
      logger.logDebug(output.stderr);
    } else {
      context.read<CodeProvider>().setOutput(output.stdout.split('\n'));
      logger.logDebug(output.stdout);
    }

    _tabController.animateTo(1);
  }

  _showDialogBox(title, hint) async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return UserInputDialog(
          title: title,
          hint: hint,
        );
      },
    );

    return result;
  }

  void _shareApp() {
    Share.share('Check out my website https://cyberkrypts.com',
        subject: 'Look what I made!');
  }

  late TabController _tabController;
  late CustomFileHandling _fileHandling;

  Future _handleClick(int value) async {
    switch (value) {
      case 0:
        logger.logDebug('open file');
        break;
      case 1:
        String filePath = context.read<CodeProvider>().filePath;
        String fileName = context.read<CodeProvider>().fileName;
        if (filePath.isNotEmpty && fileName.isNotEmpty) {
          _saveFile(false);
        } else {
          _saveFile(true);
        }
        logger.logDebug('Save');
        break;
      case 2:
        if (_tabController.index != 0) _tabController.animateTo(0);
        _saveFile(true);
        logger.logDebug('Save as');
        break;
      case 3:
        logger.logDebug('Default template');
        break;
    }
  }

  _saveFile(bool saveAs) async {
    if (saveAs) {
      String fileName = await _showDialogBox('File Name', 'Enter file name');
      fileName = fileName.endsWith(".py") ? fileName : "$fileName.py";
      logger.logDebug("file name: $fileName");
      String path = await _fileHandling.selectFolder(context);
      if (path.isEmpty) return;
      context.read<CodeProvider>().setFilePath(path);
      context.read<CodeProvider>().setFileName(fileName);
    }
    String fullPath = context.read<CodeProvider>().filePath +
        "/" +
        context.read<CodeProvider>().fileName;
    _fileHandling.saveFile(fullPath, context.read<CodeProvider>().code);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fileHandling = CustomFileHandling();
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
            IconButton(onPressed: _shareApp, icon: const Icon(Icons.share)),
            PopupMenuButton<int>(
              onSelected: (item) => _handleClick(item),
              itemBuilder: (context) => const [
                PopupMenuItem<int>(value: 0, child: Text('Open')),
                PopupMenuItem<int>(value: 1, child: Text('Save')),
                PopupMenuItem<int>(value: 2, child: Text('Save as')),
                PopupMenuDivider(),
                PopupMenuItem<int>(value: 3, child: Text('Default template')),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        CodeMirrorWidget(
          onRun: _runCode,
        ),
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.black54),
          child: const OutputTabWidget(),
        )
      ]),
    );
  }
}
