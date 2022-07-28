import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterudemy/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../todo/archive_task/archive_task_screen.dart';
import '../../todo/done_task/done_task_screen.dart';
import '../../todo/new_task/new_task_screen.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoIntialState());

  static TodoCubit get(context) => BlocProvider.of<TodoCubit>(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool isBottomSheetShown = false;

  IconData fabIcon = Icons.edit;

  late Database database;

  int currentIndex = 0;

  List<Map> tasks = [];

  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchiveTaskScreen(),
  ];
  List<String> title = [
    'New Task',
    'Done Task',
    'Archive Task',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(TodoNavBarState());
  }

  void creatDB() {
    openDatabase('todoDB.db', version: 1, onCreate: (database, version) {
      print(' DB created');
      database
          .execute(
              'Create Table List (id INTEGER PRIMARY KEY,title TEXT,date TEXT ,time TEXT,status TEXT)')
          .then((value) {
        print(' table created');
      }).catchError((error) {
        print('error Creating tabel ${error.toString()}');
      });
    }, onOpen: (database) {
      print('database opend');
    }).then((value) {
      print('inserted data to database');
      titleController.clear();
      timeController.clear();
      dateController.clear();
      getFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(GetDatabaseState());
      });
      emit(InsertDatabaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO List (title ,date,time ,status) VALUES ("$title","$date","$time","new")',
      )
          .then((value) {
        print('$value inserted succsess');
        emit(InsertDatabaseState());
        getFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(GetDatabaseState());
        });
      }).catchError((error) {
        print('not inserted  ${error.toString()}');
      });
      throw ('error');
    });
  }

  Future<List<Map>> getFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM List');
  }

  void ChangeBottomSheet({
    required IconData icon,
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(BottomSheetState());
  }
}
