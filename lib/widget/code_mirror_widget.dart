import 'dart:async';

import 'package:cyberkrypts/log/logger.dart';
import 'package:cyberkrypts/provider/code_provider.dart';
import 'package:cyberkrypts/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodeMirrorWidget extends StatefulWidget {
  final Function onRun;
  const CodeMirrorWidget({Key? key, required this.onRun}) : super(key: key);

  @override
  State<CodeMirrorWidget> createState() => _CodeMirrorWidgetState();
}

class _CodeMirrorWidgetState extends State<CodeMirrorWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Logger logger = Logger('CodeMirrorWidget');

  @override
  void initState() {
    super.initState();
  }

  _initCode(controller) {
    controller.runJavascript(
        'window.editor.setValue(`${context.read<CodeProvider>().code}`)');
  }

  _onCodeChange(s) {
    context.read<CodeProvider>().setCode(s.message);
  }

  _onEditorReady(s) {
    _controller.future.then((controller) {
      _initCode(controller);
      logger.logDebug('code initialized');
    });
  }

  _onKeyPress(String key) async {
    if (key.isNotEmpty) {
      var controller = await _controller.future;
      controller
          .runJavascript('document.execCommand("insertText", false, `$key`);');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _controller.complete(webViewController);
            await webViewController
                .loadFlutterAsset('assets/html/code_mirror.html');
            // _initCode(webViewController);
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
              name: 'onCodeChange',
              onMessageReceived: _onCodeChange,
            ),
            JavascriptChannel(
              name: 'onEditorReady',
              onMessageReceived: _onEditorReady,
            ),
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 75,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ToolBarWidget(
              onKeyPress: _onKeyPress,
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

// referance - https://stackoverflow.com/questions/63205537/how-to-listen-to-events-in-flutter-webview