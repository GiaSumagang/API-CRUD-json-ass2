import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/todo_model.dart';

class AddList extends StatefulWidget {
  final List<dynamic> data;

  const AddList({required this.data, Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

createTodo(var data) async {
  var response = await http.patch(Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        'id': data['id'],
        'userId': data['userId'],
        'title': data['title'],
        'completed': data['completed'],
      }));
  if (response.statusCode == 201) {
    print('Successfully added a task!');
    var display = response.body;
    print(display);

    String todoResponse = response.body;
    todoModelFromJson(todoResponse);
  } else {
    throw Exception('Tasked Failed Successfully');
  }
  throw Exception('Tasked Failed Successfully');
}


class _AddListState extends State<AddList> {
  var useridController = TextEditingController();
  var titleController = TextEditingController();

  Todo? task;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create Todo-List'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          TextFormField(
            controller: useridController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: "User Id", labelText: "User ID"),
            validator: (value) {
              return (value == '') ? 'Please enter User ID' : null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration:
                const InputDecoration(hintText: "Title", labelText: "Title"),
            validator: (value) {
              return (value == '') ? 'Please enter Title' : null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var finalData = createTodo([
                      useridController.text,
                      titleController.text,
                      false
                      ]);
                  Navigator.pop(context, finalData);
                } else {
                  return;
                }
              },
              child: const Text('Add Todo')),
        ]),
      ),
    );
  }
}
