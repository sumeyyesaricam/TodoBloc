
import 'package:equatable/equatable.dart';

abstract class TaskListEvent extends Equatable{
  TaskListEvent([List props = const []]) : super(props);
}

class TaskListLoad extends TaskListEvent {

  TaskListLoad() : super();

  @override
  String toString() => 'TaskListLoad';
}
