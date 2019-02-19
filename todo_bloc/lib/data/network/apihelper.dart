import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_bloc/data/model/task.dart';

class ApiHelper {
  final Firestore db = Firestore.instance;
  Future<Task> addTask(Task task) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      var document = db.collection("task").document();
      task.taskId = document.documentID;
      await document.setData(task.toMap());
      return task.toMap();
    };
    return await db.runTransaction(createTransaction).then((mapData) {
      return task;
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<List<Task>> getTasks() async {
    List<Task> tasks = new List<Task>();
    final _tasks = await db.collection('task').getDocuments().then((snapShot) {
      tasks.addAll(snapShot.documents.map((doc) => Task.fromMap(doc.data)));
      return tasks;
    }).catchError((error) {
      return tasks;
    });
    return _tasks;
  }
}
