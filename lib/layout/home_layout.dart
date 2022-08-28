import 'package:flutter/material.dart';
import 'package:test_one/modules/archived_tasks/archived_task.dart';
import 'package:test_one/modules/done_tasks/done_task.dart';
import 'package:test_one/modules/new_tasks/new_task.dart';

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

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var name = await getName();
            print(name);
            throw ('Some error');
          } catch (error) {
            print('erro is ${error.toString()}');
          }
        },
        child: const Icon(Icons.add),
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
