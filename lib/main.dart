import 'package:flutter/material.dart';
import 'package:weptoon/screens/homeScreen.dart';
import 'package:weptoon/services/apiService.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}