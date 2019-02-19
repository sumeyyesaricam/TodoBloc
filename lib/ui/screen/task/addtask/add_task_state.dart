import 'package:meta/meta.dart';

abstract class AddTaskState   {
  AddTaskState([List props = const []]) : super();
}

class AddTaskInitial extends AddTaskState {
  @override
  String toString() => 'AddTaskInitial';
}
class AddTaskSuccess extends AddTaskState {
  @override
  String toString() => 'AddTaskSuccess';
}

class AddTaskLoading extends AddTaskState {
  @override
  String toString() => 'AddTaskLoading';
}

class AddTaskFailure extends AddTaskState {
  final String error;

  AddTaskFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'AddTaskFailure { error: $error }';
}