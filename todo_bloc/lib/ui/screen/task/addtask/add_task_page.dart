import 'package:flutter/material.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task_form.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskRepository addTaskRepository;
  AddTaskPage({Key key, this.addTaskRepository})
      : assert(addTaskRepository != null),
        super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  AddTaskBloc _addTaskBloc;

  AddTaskRepository get _addTaskRepository => widget.addTaskRepository;

  @override
  void initState() {
    _addTaskBloc = AddTaskBloc(
      addTaskRepository: _addTaskRepository,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Ekle'),
      ),
      body: AddTaskForm(
        addTaskBloc: _addTaskBloc,
      ),
    );
  }

  @override
  void dispose() {
    _addTaskBloc.dispose();
    super.dispose();
  }
}
