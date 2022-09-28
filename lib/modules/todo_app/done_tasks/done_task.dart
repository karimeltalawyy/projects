import 'package:flutter/material.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Done Tasks',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
    );
  }
}
