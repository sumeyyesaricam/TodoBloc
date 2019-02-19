import 'package:meta/meta.dart';

import 'package:todo_bloc/data/model/task.dart';
import 'package:todo_bloc/data/network/apihelper.dart';

class AddTaskRepository {
  final ApiHelper apiHelper;

  AddTaskRepository({@required this.apiHelper})
      : assert(apiHelper != null);

  Future<Task> addTask(String content) async {
    var task=Task(content: content,taskId: "",status: 1);
    return await apiHelper.addTask(task);
  }
}