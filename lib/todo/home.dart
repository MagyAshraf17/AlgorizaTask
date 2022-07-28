import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterudemy/features/database.dart';
import 'package:flutterudemy/shared/cubit/cubit.dart';
import 'package:flutterudemy/shared/cubit/states.dart';
import 'package:flutterudemy/todo/archive_task/archive_task_screen.dart';
import 'package:flutterudemy/todo/done_task/done_task_screen.dart';
import 'package:flutterudemy/todo/new_task/new_task_screen.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../shared/components/text_field.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..creatDB(),
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (BuildContext context, TodoStates state) {
          if (state is InsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          return MaterialApp(
            home: DefaultTabController(
              length: 3,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: Text(cubit.title[cubit.currentIndex]),
                  bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.amberAccent,
                      //currentIndex: cubit.currentIndex,
                      onTap: (index) {
                        cubit.changeIndex(index);
                      },
                      tabs: const [
                        Tab(
                          text: 'New Task ',
                        ),
                        Tab(
                          text: 'Done Task',
                        ),
                        Tab(
                          text: 'Archived Task',
                        ),
                      ]),
                ),
                body: ConditionalBuilder(
                  condition: state is! GetDatabaseLoadingState,
                  builder: (context) => cubit.screens[cubit.currentIndex],
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (cubit.isBottomSheetShown) {
                      if (formKey.currentState!.validate()) {
                        cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text,
                        );
                      }
                    } else {
                      scaffoldKey.currentState
                          ?.showBottomSheet(
                            (context) => Container(
                              color: Colors.grey[200],
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FiledText(
                                        onTap: () {},
                                        controller: titleController,
                                        inputType: TextInputType.text,
                                        prefix: Icons.title_rounded,
                                        textLabel: ' New  Task',
                                        textValidate: 'title must not be empty',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      FiledText(
                                        controller: timeController,
                                        inputType: TextInputType.datetime,
                                        prefix: Icons.timelapse,
                                        textLabel: ' Time Task',
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                          });
                                        },
                                        textValidate: 'time must not be empty',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      FiledText(
                                          controller: dateController,
                                          inputType: TextInputType.datetime,
                                          prefix: Icons.calendar_today,
                                          textLabel: ' Date Task',
                                          textValidate:
                                              'time must not be empty',
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2022-09-30'),
                                            ).then(
                                              (value) {
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!);
                                              },
                                            );
                                          }),
                                    ]),
                              ),
                            ),
                          )
                          .closed
                          .then((value) {
                        cubit.ChangeBottomSheet(
                          icon: Icons.edit,
                          isShow: false,
                        );
                      });
                      cubit.ChangeBottomSheet(
                        icon: Icons.add,
                        isShow: true,
                      );
                    }
                  },
                  child: Icon(cubit.fabIcon),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
