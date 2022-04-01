import 'package:cyberkrypts/provider/code_provider.dart';
import 'package:cyberkrypts/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:provider/provider.dart';

class CodeEditorWidget extends StatefulWidget {
  final Function onRun;
  const CodeEditorWidget({Key? key, required this.onRun}) : super(key: key);

  @override
  _CodeEditorWidgetState createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
// Add a controller
  RichTextController? _controller;
  final List<String> _lineNumbers = [];
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerTextField = ScrollController();
  int tabCount = 0;
  bool isNewLine = false;

  @override
  void initState() {
    _controller = RichTextController(
      patternMatchMap: {
        RegExp(r"(if)"): const TextStyle(color: Colors.red),
        RegExp(r"(else)"): const TextStyle(color: Colors.red),
        RegExp(r"(def\s)"): const TextStyle(color: Colors.red),
        RegExp(r"(for\s)"): const TextStyle(color: Colors.amber),
        RegExp(r"(\sin\s)"): const TextStyle(color: Colors.amber),
        RegExp(r"(while\s)"): const TextStyle(color: Colors.amber),
        RegExp(r"(class\s)"): const TextStyle(color: Colors.blue),
        RegExp(r"(this\.)"): const TextStyle(color: Colors.blue),
        RegExp(r"(\sself|self)"): const TextStyle(color: Colors.blue),
        RegExp(r"(range\(.*\))"): const TextStyle(color: Colors.orange),
        RegExp(r'import\s'): const TextStyle(color: Colors.orange),
        RegExp(r'"(.*?)"'): const TextStyle(color: Colors.yellow),
        RegExp(r"'(.*?)'"):
            const TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic),
        RegExp(r'"""(.*?)"""'): const TextStyle(color: Colors.yellow),
        RegExp(r"'''(.*?)'''"): const TextStyle(color: Colors.yellow),
      },
      onMatch: (List<String> matches) {},
      deleteOnBack: false,
    );
    for (int i = 1; i <= 45; i++) {
      _lineNumbers.add(i.toString());
    }

    _controller?.text = context.read<CodeProvider>().code;

    super.initState();
  }

  _concatString(String str) {
    if (_controller != null) {
      TextSelection selection = _controller!.selection;
      int offset = selection.baseOffset;
      String text = _controller!.text;
      _controller!.text =
          text.substring(0, offset) + str + text.substring(offset);
      _controller!.selection =
          TextSelection.collapsed(offset: offset + str.length);
    }
  }

  _codeAutoTab() {
    for (int i = 0; i < tabCount; i++) {
      _concatString('\t');
    }
  }

  _onTextChanged(data) {
    context.read<CodeProvider>().setCode(_controller?.text);
    if (data.isNotEmpty && data.codeUnitAt(0) == 10) {
      _addLineNumbers();
      _codeAutoTab();
    }
  }

  onKeyPress(String key) {
    if (key == '\t') {
      tabCount++;
    }
    _concatString(key);
  }

  _addLineNumbers() {
    RegExp regExp = RegExp(r"(\r\n|\r|\n)");
    if (_controller != null) {
      String? text = _controller?.text;
      int length = regExp.allMatches(text!).length;
      int newNumber = int.parse(_lineNumbers[_lineNumbers.length - 1]);
      if (length >= newNumber) {
        setState(() {
          newNumber = newNumber + 1;
          _lineNumbers.add(newNumber.toString());
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _scrollController.dispose();
    _scrollControllerTextField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 26, 26, 26),
            ),
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    controller: _controller,
                    onChanged: _onTextChanged,
                    scrollController: _scrollControllerTextField,
                    minLines: 45,
                    keyboardType: TextInputType.multiline,
                    autocorrect: false,
                    scrollPadding: EdgeInsets.zero,
                    autofocus: false,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your code here',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 26, 26, 26),
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 0,
                            ),
                            child: Column(
                              children: [
                                ..._lineNumbers.map(
                                  (number) => Text(
                                    number,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.amber[800],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ToolBarWidget(
              onKeyPress: onKeyPress,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.zero,
            height: 50,
            width: 75,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 64, 149, 67)),
            child: TextButton(
              child: const Text(
                'Run',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                widget.onRun();
              },
            ),
          ),
        ),
      ],
    );
  }
}


// referance -> https://github.com/BaderEddineOuaich/flutter_syntax_view/blob/bd01c14c6c6f8de1949a1a10270b67b515998076/lib/src/syntax/javascript.dart