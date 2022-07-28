import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterudemy/shared/cubit/cubit.dart';
import 'package:flutterudemy/shared/cubit/states.dart';

import '../../shared/components/task_item.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).tasks;

        return ListView.separated(
            itemBuilder: ((context, index) => TaskItem(
                  model: TodoCubit.get(context).tasks[index],
                )),
            separatorBuilder: (((context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[200],
                ))),
            itemCount: TodoCubit.get(context).tasks.length);
      },
    );
  }
}
