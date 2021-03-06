import 'package:cyberkrypts/common/file_handling.dart';
import 'package:cyberkrypts/common/python_interpreter.dart';
import 'package:cyberkrypts/log/logger.dart';
import 'package:cyberkrypts/provider/code_provider.dart';
import 'package:cyberkrypts/widget/code_mirror_widget.dart';
import 'package:cyberkrypts/widget/output_tab.dart';
import 'package:cyberkrypts/widget/user_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompilerScreen extends StatefulWidget {
  const CompilerScreen({Key? key}) : super(key: key);

  @override
  State<CompilerScreen> createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen>
    with TickerProviderStateMixin {
  Logger logger = Logger('CompilerScreen');

  // ignore: non_constant_identifier_names
  String pythonFileName = '';
  String pythonCode = '';
  int renderKey = 0;

  _runCode() async {
    // show result as alert
    String stdin = await _showDialogBox(
      'Input',
      'Enter your input here / use new line for multiple inputs',
    );
    String code = context.read<CodeProvider>().code;
    // String stdin = context.read<CodeProvider>().stdin;

    var output =
        await PythonInterpreter.runPythonCode(code, stdin, pythonFileName);
    if (output == null) return;

    if (output.stderr.isNotEmpty) {
      context.read<CodeProvider>().setOutput(output.stderr);
    } else {
      context.read<CodeProvider>().setOutput(output.output);
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
    Share.share(
        'Check out my project https://github.com/thelonewolf123/cyebrkrypts_flutter',
        subject: 'Look what I made!');
  }

  late TabController _tabController;
  late CustomFileHandling _fileHandling;

  Future _handleClick(int value) async {
    switch (value) {
      case 0:
        logger.logDebug('open file');
        String code = await _openFile();
        context.read<CodeProvider>().setCode(code);
        break;
      case 1:
        String filePath = context.read<CodeProvider>().filePath;
        String fileName = context.read<CodeProvider>().fileName;
        if (filePath.isNotEmpty && fileName.isNotEmpty) {
          await _saveFile(false);
        } else {
          await _saveFile(true);
        }
        logger.logDebug('Save');
        break;
      case 2:
        if (_tabController.index != 0) _tabController.animateTo(0);
        await _saveFile(true);
        logger.logDebug('Save as');
        break;
      case 3:
        logger.logDebug('Default template');
        context.read<CodeProvider>().setCode('print("Hello World!")');
        break;
    }

    _initCode();
  }

  _saveFile(bool saveAs) async {
    if (saveAs) {
      String fileName = '';
      try {
        fileName = await _showDialogBox('File Name', 'Enter file name');
      } catch (e) {
        logger.logError('Error while saving file: $e');
        return;
      }
      fileName = fileName.endsWith(".py") ? fileName : "$fileName.py";
      logger.logDebug("file name: $fileName");
      String path = await _fileHandling.selectFolder(context);
      if (path.isEmpty) return;
      context.read<CodeProvider>().setFilePath(path);
      context.read<CodeProvider>().setFileName(fileName);
      String fullPath = '$path/$fileName';
      _fileHandling.saveFile(fullPath, context.read<CodeProvider>().code);
    }
    String folderPath = context.read<CodeProvider>().filePath;
    String file = context.read<CodeProvider>().fileName;
    String fullPath = "$folderPath/$file";
    _fileHandling.saveFile(fullPath, context.read<CodeProvider>().code);

    Fluttertoast.showToast(
        msg: "File saved successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<String> _openFile() async {
    String filePath = await _fileHandling.selectFile(context);
    if (filePath.isEmpty) return '';
    String fileName = filePath.split('/').last;
    filePath = filePath.substring(0, filePath.length - fileName.length - 1);
    context.read<CodeProvider>().setFilePath(filePath);
    context.read<CodeProvider>().setFileName(fileName);
    String content = await _fileHandling.readFile('$filePath/$fileName');
    logger.logDebug('file content: $content');
    return content;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fileHandling = CustomFileHandling();
    _initCode();
  }

  _initCode() {
    setState(() {
      pythonFileName = context.read<CodeProvider>().fileName;
      pythonCode = context.read<CodeProvider>().code;
      renderKey++;
    });
  }

  _onCodeChange(s) {
    context.read<CodeProvider>().setCode(s);
    setState(() {
      pythonCode = s;
    });
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
          key: ValueKey(renderKey),
          title: Text(pythonFileName),
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
          key: ValueKey(renderKey),
          onRun: _runCode,
          onChange: _onCodeChange,
          code: pythonCode,
        ),
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(color: Color.fromRGBO(34, 34, 34, 1)),
          child: const OutputTabWidget(),
        )
      ]),
    );
  }
}
