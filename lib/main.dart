import 'package:cyberkrypts/provider/compiler_tab_provider.dart';
import 'package:cyberkrypts/widget/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyberkrypts/provider/code_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CodeProvider()),
        ChangeNotifierProvider(create: (context) => CompilerTabProvider()),
      ],
      child: MaterialApp(
        title: 'CyberKrypts App',
        initialRoute: '/',
        routes: {
          '/': (context) => const SafeArea(child: BottomNavBarWidget()),
        },
      ),
    ),
  );
}
