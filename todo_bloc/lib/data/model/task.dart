import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String taskId;
  String content;
  int status;

  DocumentReference reference;
  Task({this.taskId, this.content, this.status});

  Task.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map != null && map["content"] != null),
        assert(map != null && map["status"] != null),
        taskId = map["taskId"],
        content = map["content"],
        status = map["status"];

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map toMap() {
    var dataMap = new Map<String, dynamic>();
    dataMap['taskId'] = taskId;
    dataMap["content"] = content;
    dataMap["status"] = status;
    return dataMap;
  }
}
