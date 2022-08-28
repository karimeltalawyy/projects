import 'package:flutter/material.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Archived Tasks',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
    );
  }
}
