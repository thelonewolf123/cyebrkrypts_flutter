import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MonacoEdiot extends StatefulWidget {
  const MonacoEdiot({Key? key}) : super(key: key);

  @override
  State<MonacoEdiot> createState() => _MonacoEdiotState();
}

// initialFile: "http://localhost:8080/assets/website/index.html",
//       initialUrlRequest: URLRequest(
//   url: Uri.parse('https://www.google.com'),
// ),
class _MonacoEdiotState extends State<MonacoEdiot> {
  @override
  Widget build(BuildContext context) {
    return const InAppWebView(
      initialFile: "assets/test/index.html",
    );
  }
}
