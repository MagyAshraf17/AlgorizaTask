import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterudemy/modules/login/login-page.dart';
import 'package:flutterudemy/shared/cubit/cubit.dart';
import 'package:flutterudemy/shared/cubit/states.dart';
import 'package:flutterudemy/todo/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<TodoCubit>(create: (context) => TodoCubit())],
      child: MaterialApp(
        home: HomeLayout(),
      ),
    );
  }
}
