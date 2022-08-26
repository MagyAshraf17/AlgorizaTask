import 'package:flutter/material.dart';
import 'package:flutterudemy/shared/cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  final Map model;

  const TaskItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Icon(Icons.check_box_outlined),
          const SizedBox(
            width: 30.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' ${model['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30.0,
          ),
          IconButton(
            onPressed: () {
              TodoCubit.get(context)
                  .updateDatadase(status: 'done', id: model['id']);
            },
            icon: const Icon(
              Icons.check_circle_outline_rounded,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.archive_outlined,
            ),
          )
        ],
      ),
    );
  }
}
