import 'package:flutter/material.dart';

class TodoDetails extends StatefulWidget {
  final dynamic todo;

  const TodoDetails({required this.todo, Key? key}) : super(key: key);

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  Widget rowItem(String title, dynamic value) {
    return Card(
      elevation: 10,
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 160,
                child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  )
            ),
            SizedBox(
              width: 150,
              child: Text(value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          rowItem("ID:", widget.todo["id"]),
          rowItem("User ID:", widget.todo["userId"]),
          rowItem("Title:", widget.todo["title"]),
          rowItem("Completed:", widget.todo["completed"])
        ],
      ),
    );
  }
}
