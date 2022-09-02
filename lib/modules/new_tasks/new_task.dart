import 'package:flutter/material.dart';
import 'package:test_one/shared/component/components/components.dart';

import '../../shared/component/constants/constants.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(),
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1.0,
      ),
      itemCount: tasks.length,
    );
  }
}
