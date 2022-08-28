import 'package:flutter/material.dart';
import 'package:test_one/layout/home_layout.dart';
import 'package:test_one/modules/bmi/bmi_calculator.dart';
import 'package:test_one/modules/counter/counter_screen.dart';
import 'package:test_one/modules/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
