import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, Cubit;
import 'package:flutterudemy/shared/cubit/states.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../todo/archive_task/archive_task_screen.dart';
import '../../todo/done_task/done_task_screen.dart';
import '../../todo/new_task/new_task_screen.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoIntialState());

  static TodoCubit get(context) => BlocProvider.of<TodoCubit>(context);

  bool isBottomSheetShown = false;

  IconData fabIcon = Icons.edit;

  late Database database;

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController statusController = TextEditingController();
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

  void creatDB() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'todo.db');
    debugPrint('Todo database Created');
    opentTodoDatabase(path: path);
    emit(CreateDatabaseState());
  }

  void opentTodoDatabase({
    required String path,
  }) async {
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table

        await db.execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)');

        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('database opend ');
        database = db;
        getTasksDatabase();
      },
    );
  }

  void insertTaskDatabase() async {
    database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Task(title, date, time,status) VALUES("${titleController.text}", "${dateController.text}", "${timeController.text}","new")');
    }).then((value) {
      debugPrint('inserted data to database');
      titleController.clear();
      timeController.clear();
      dateController.clear();
      emit(InsertTaskToDatabaseState());
    });
  }

  void getTasksDatabase() async {
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM Task').then((value) {
      tasks = value;
      print(tasks);
      emit(GetDatabaseState());
    });
  }

  // Map selectedTask = {};

  // void selectedToUpdateTask({
  //   required Map updateTask,
  // }) {
  //   selectedTask = updateTask;
  //   statusController.text = selectedTask['status'];
  // }

  void updateDatadase({required String status, required int id}) async {
    return await database.rawUpdate('UPDATE Task SET status = ? WHERE id = ?',
        ['${status}', id]).then((value) {
      emit(UpdateTaskToDatabaseState());
      debugPrint('updated tasks');
      print(tasks);
    });
  }

  Future<void> changeBottomSheet({
    required IconData icon,
    required bool isShow,
  }) async {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(BottomSheetState());
  }
}
