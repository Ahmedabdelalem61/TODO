import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_todo/modules/archived_tasks/archived_tasks.dart';
import 'package:task_todo/modules/done_tasks/done%20tasks.dart';
import 'package:task_todo/modules/new_tasks/new_tasks.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ['new task', 'done task', 'archive task'];
  List<Map> tasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  Database dataBase;

  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (dataBase, version) {
      print('data base are created');
      dataBase
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        print('table are created');
      }).catchError((error) {
        print('there are ${error} error'.toString());
      });
    }, onOpen: (dataBase) {
      getDataFromDataBase(dataBase).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDataBaseState());
      });
      print('data base opened');
    }).then((value) {
      dataBase = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future<List<Map>> getDataFromDataBase(dataBase) async {
    return await dataBase.rawQuery('SELECT * FROM tasks');
  }

  void insertToDataBase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('${value}inserted Successfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(dataBase).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataBaseState());
        });
      }).catchError((error) {
        print('error when insrting raw ${error.toString()}');
      });
      return null;
    });
  }

  bool isBottomshowen = false;
  IconData fabIcon = Icons.add;

  void ChangeBottomSheetState(
      {@required IconData icon, @required bool isShow}) {
    isBottomshowen = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
