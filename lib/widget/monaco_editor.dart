import 'package:asset_webview/asset_webview.dart';
import 'package:flutter/material.dart';

class MonacoEdiot extends StatefulWidget {
  const MonacoEdiot({Key? key}) : super(key: key);

  @override
  State<MonacoEdiot> createState() => _MonacoEdiotState();
}
// initialFile: "http://localhost:8080/assets/website/index.html",
class _MonacoEdiotState extends State<MonacoEdiot> {
  @override
  Widget build(BuildContext context) {
    return AssetWebview(initialUrl: 'asset://local/assets/website/index.html');
  }
}
