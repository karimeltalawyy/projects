import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_one/modules/archived_tasks/archived_task.dart';
import 'package:test_one/modules/done_tasks/done_task.dart';
import 'package:test_one/modules/new_tasks/new_task.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../shared/component/components/components.dart';
import '../../shared/component/constants/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timingController = TextEditingController();
  var dateController = TextEditingController();
  Database? db;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.screens[cubit.currentIndex],
              condition: state is! AppGetLoadingState,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    print('Form submitted');

                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timingController.text,
                      date: dateController.text,
                    );
                    // insertToDatabase(
                    //         date: dateController.text,
                    //         time: timingController.text,
                    //         title: titleController.text)
                    //     .then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);

                    //     // setState(() {
                    //     //   tasks = value;
                    //     //   fabIcon = Icons.edit;
                    //     //   isBottomSheetShown = false;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormFeild(
                                  autoValidate:
                                      AutovalidateMode.onUserInteraction,
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Title must not be empty';
                                    return null;
                                  },
                                  onTap: () {
                                    print('Title added');
                                  },
                                  label: 'Task title',
                                  hint: 'Enter title',
                                  prefix: Icons.title,
                                ),
                                const SizedBox(height: 12),
                                defaultFormFeild(
                                  autoValidate:
                                      AutovalidateMode.onUserInteraction,
                                  controller: timingController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timingController.text = value
                                          ?.format(context)
                                          .toString() as String;
                                      print(value?.format(context));
                                    });
                                  },
                                  // isClickable: false,
                                  validate: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Time must not be empty';
                                    return null;
                                  },
                                  label: 'Task Time',
                                  hint: 'Enter Task time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                const SizedBox(height: 12),
                                defaultFormFeild(
                                  autoValidate:
                                      AutovalidateMode.onUserInteraction,
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-09-15'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  // isClickable: false,
                                  validate: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Date must not be empty';
                                    return null;
                                  },
                                  label: 'Task Date',
                                  hint: 'Enter Task Date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> getName() async {
    return 'Karim khaled';
  }
}
