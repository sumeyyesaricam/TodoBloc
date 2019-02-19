
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/data/model/task.dart';

abstract class TaskListState extends Equatable {
  TaskListState([List props = const []]) : super(props);
}

class TasksEmpty extends TaskListState {}

class TasksLoading extends TaskListState {}

class TasksLoaded extends TaskListState {
  final List<Task> taskList;

  TasksLoaded({@required this.taskList})
      : assert(taskList != null),
        super([taskList]);
}
