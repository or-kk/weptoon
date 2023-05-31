import 'package:flutter/material.dart';
import 'package:weptoon/screens/home.dart';
import 'package:weptoon/services/apiService.dart';

void main() {
  ApiService().getTodayToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Home(),
      ),
    );
  }
}