import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_one/modules/archived_tasks/archived_task.dart';
import 'package:test_one/modules/done_tasks/done_task.dart';
import 'package:test_one/modules/new_tasks/new_task.dart';
import 'package:path/path.dart';

import '../shared/component/components/components.dart';

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
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            }
          } else {
            scaffoldKey.currentState!.showBottomSheet((context) => Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormFeild(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Title must not be empty';
                            }
                          },
                          label: 'Task title',
                          hint: 'Enter title',
                          prefix: Icons.title,
                        ),
                        const SizedBox(height: 12),
                        defaultFormFeild(
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
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Time must not be empty';
                            }
                          },
                          label: 'Task Time',
                          hint: 'Enter Task time',
                          prefix: Icons.watch_later_outlined,
                        ),
                        const SizedBox(height: 12),
                        defaultFormFeild(
                          controller: dateController,
                          type: TextInputType.datetime,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2022-09-05'),
                            ).then((value) {
                              print(value.toString());
                            });
                          },
                          // isClickable: false,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Date must not be empty';
                            }
                          },
                          label: 'Task Date',
                          hint: 'Enter Task Date',
                          prefix: Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ));
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
              'CREATE TABLE tasks(id INTEGER, title TEXT, date TEXT, time TEXT, status TEXT)')
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

void insertToDatabase() {
  database?.transaction((txn) async {
    txn
        .rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES ("first task","0202","89","New")')
        .then((value) {
      print('$value Inserted Succcessfuly');
    }).catchError(
      (error) {
        print('Error while inserting is ${error.toString()}');
      },
    );
  });
}
