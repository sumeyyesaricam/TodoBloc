import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/model/task.dart';
import 'package:todo_bloc/data/network/apihelper.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task_page.dart';
import 'package:todo_bloc/ui/screen/task/tasklist/task_list.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key key, this.taskListRepository}) : super(key: key);

  final TaskListRepository taskListRepository;

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  TaskListBloc _taskListBloc;
  @override
  void initState() {
    super.initState();
    _taskListBloc = TaskListBloc(taskListRepository: widget.taskListRepository);
    _taskListBloc.dispatch(TaskListLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: Center(
        child: BlocBuilder<TaskListEvent, TaskListState>(
          bloc: _taskListBloc,
          builder: (
            BuildContext context,
            TaskListState state,
          ) {
            if (state is TasksEmpty) {
              return Text("Boş Liste");
            } else if (state is TasksLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TasksLoaded) {
              final taskList = state.taskList;
              return ListView(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: taskList.map((Task task) {
                  return Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(task.content)),
                  );
                }).toList(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selam',
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodo() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(builder: (context) {
      return AddTaskPage(
          addTaskRepository: AddTaskRepository(apiHelper: ApiHelper()));
    }));
  }

  @override
  void dispose() {
    _taskListBloc.dispose();
    super.dispose();
  }
}
