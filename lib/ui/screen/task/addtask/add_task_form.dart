import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/network/apihelper.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task.dart';
import 'package:todo_bloc/ui/screen/task/tasklist/task_list.dart';

class AddTaskForm extends StatefulWidget {
  final AddTaskBloc addTaskBloc;

  AddTaskForm({
    Key key,
    @required this.addTaskBloc,
  }) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _contentController = TextEditingController();

  AddTaskBloc get _addTaskBloc => widget.addTaskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskEvent, AddTaskState>(
      bloc: _addTaskBloc,
      builder: (
        BuildContext context,
        AddTaskState state,
      ) {
        if (state is AddTaskFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        } else if (state is AddTaskSuccess) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Görev başarıyla eklendi.'),
                backgroundColor: Colors.green,
              ),
            );
          });
        }
        return Form(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new TextField(
                    controller: _contentController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.green),
                      ),
                      contentPadding: new EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                      hintText: 'Görev içeriğini giriniz...',
                      hintStyle: new TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'helvetica_neue_light',
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _onAddTaskButtonPressed();
                      },
                      color: Colors.green,
                      child: new Text(
                        'Görev Ekle',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _showTaskListPressed();
                      },
                      color: Colors.redAccent,
                      child: new Text(
                        'Görev Listesi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              _buildLoading(state)
            ],
          ),
        ));
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onAddTaskButtonPressed() {
    _addTaskBloc.dispatch(AddTaskPressed(
      content: _contentController.text,
    ));
    _contentController.text="";
  }

  Widget _buildLoading(state) {
    if (state is AddTaskLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SizedBox();
    }
  }

  void _showTaskListPressed() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(builder: (context) {
      return TaskListPage(
          taskListRepository: TaskListRepository(apiHelper: ApiHelper()));
    }));
  }
}
