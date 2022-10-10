import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/cubit/cubit.dart';
import 'package:test_one/shared/cubit/states.dart';

import '../../../shared/component/constants/constants.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
