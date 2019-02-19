import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddTaskEvent extends Equatable{
  AddTaskEvent([List props = const []]) : super(props);
}

class AddTaskPressed extends AddTaskEvent {
  final String content;

  AddTaskPressed({
    @required this.content,
  }) : super([content]);

  @override
  String toString() => 'AddTaskPressed';
}
