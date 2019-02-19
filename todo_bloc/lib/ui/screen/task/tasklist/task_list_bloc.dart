import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/ui/screen/task/tasklist/task_list.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskListRepository taskListRepository;

  TaskListBloc({
    @required this.taskListRepository,
  }) : assert(taskListRepository != null);

  @override
  TaskListState get initialState => TasksEmpty();

  @override
  Stream<TaskListState> mapEventToState(
    TaskListState currentState,
    TaskListEvent event,
  ) async* {
    if (event is TaskListLoad) {
      yield TasksLoading();
      try {
        var tasks = await taskListRepository.getTaskList();
        yield TasksLoaded(taskList: tasks);
      } catch (error) {
        yield TasksEmpty();
      }
    }
  }
}
