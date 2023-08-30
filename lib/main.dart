import 'package:ecommerce/login.dart';
import 'package:ecommerce/session_storage.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Main(),
      theme: SessionStorage.isDarkMode ? darkmode : lightMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Login(),
    );
  }
}
