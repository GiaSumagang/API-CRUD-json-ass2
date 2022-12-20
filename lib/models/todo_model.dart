import 'dart:convert';

Todo todoModelFromJson(String str) => Todo.fromJson(json.decode(str));
String todoModelToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo(
      {required this.id,
        required this.userid,
        required this.title,
        required this.completed});

  int? userid;
  int? id;
  String? title;
  bool? completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    userid: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userid,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
