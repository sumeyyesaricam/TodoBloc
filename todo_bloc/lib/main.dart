import 'package:flutter/material.dart';
import 'package:todo_bloc/data/network/apihelper.dart';
import 'package:todo_bloc/ui/screen/task/tasklist/task_list.dart';
import 'package:todo_bloc/ui/screen/task/tasklist/task_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListPage(taskListRepository: TaskListRepository(apiHelper: ApiHelper()),),
    );
  }
}

