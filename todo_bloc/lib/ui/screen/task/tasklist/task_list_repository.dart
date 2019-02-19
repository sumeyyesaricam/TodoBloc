
import 'package:meta/meta.dart';
import 'package:todo_bloc/data/model/task.dart';
import 'package:todo_bloc/data/network/apihelper.dart';

class TaskListRepository {
  final ApiHelper apiHelper;

  TaskListRepository({@required this.apiHelper})
      : assert(apiHelper != null);

  Future<List<Task>> getTaskList() async {
    return await apiHelper.getTasks();
  }
}