import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_bloc/ui/screen/task/addtask/add_task.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTaskRepository addTaskRepository;

  AddTaskBloc({
    @required this.addTaskRepository,
  }) : assert(addTaskRepository != null);

  @override
  AddTaskState get initialState => AddTaskInitial();

  @override
  Stream<AddTaskState> mapEventToState(
    AddTaskState currentState,
    AddTaskEvent event,
  ) async* {
    if (event is AddTaskPressed) {
      yield AddTaskLoading();
      try {
        await addTaskRepository.addTask(
          event.content,
        );
        yield AddTaskSuccess();
      } catch (error) {
        yield AddTaskFailure(error: error.toString());
      }
    }
  }
}
