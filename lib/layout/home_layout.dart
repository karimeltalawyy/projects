import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_one/modules/archived_tasks/archived_task.dart';
import 'package:test_one/modules/done_tasks/done_task.dart';
import 'package:test_one/modules/new_tasks/new_task.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../shared/component/components/components.dart';
import '../shared/component/constants/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

int currentIndex = 0;
List<Widget> screens = const [
  NewTaskScreen(),
  DoneTaskScreen(),
  ArchivedTaskScreen(),
];
List<String> titles = const [
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
];
Database? database;
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
bool isBottomSheetShown = false;
IconData fabIcon = Icons.edit;
var titleController = TextEditingController();
var timingController = TextEditingController();
var dateController = TextEditingController();

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: ConditionalBuilder(
        builder: (context) => screens[currentIndex],
        condition: tasks.length > 0,
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              print('Form submitted');
              insertToDatabase(
                      date: dateController.text,
                      time: timingController.text,
                      title: titleController.text)
                  .then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);

                  setState(() {
                    tasks = value;
                    fabIcon = Icons.edit;
                    isBottomSheetShown = false;
                  });
                });
              });
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
                            autoValidate: AutovalidateMode.onUserInteraction,
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
                            autoValidate: AutovalidateMode.onUserInteraction,
                            controller: timingController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timingController.text =
                                    value?.format(context).toString() as String;
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
                            autoValidate: AutovalidateMode.onUserInteraction,
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-09-05'),
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
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_outlined),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return 'Karim khaled';
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY NOT NULL, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then(
          (value) {
            print('Table created!');
          },
        ).catchError(
          (error) {
            print('Error when creadting table is ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        print('Database Opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","New")')
          .then((value) {
        print('$value Inserted Succcessfuly');
      }).catchError(
        (error) {
          print('Error while inserting is ${error.toString()}');
        },
      );
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }
}
