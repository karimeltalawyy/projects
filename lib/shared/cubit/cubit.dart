import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_one/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_task.dart';
import '../../modules/done_tasks/done_task.dart';
import '../../modules/new_tasks/new_task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
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

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase(
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
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
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
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError(
        (error) {
          print('Error while inserting is ${error.toString()}');
        },
      );
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      // newTasks = value;
      // print(newTasks);

      newTasks.forEach((elemnt) {
        if (elemnt['status'] == 'New')
          newTasks.add(elemnt);
        else if (elemnt['status'] == 'Done')
          doneTasks.add(elemnt);
        else
          archiveTasks.add(elemnt);
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawUpdate(
      'DELETE FROM tasks  WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomNavBarState());
  }
}
