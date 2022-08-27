import 'package:flutter/material.dart';
import 'package:test_one/layout/bmi/bmi_calculator.dart';
import 'package:test_one/layout/counter/counter_screen.dart';
import 'package:test_one/layout/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
