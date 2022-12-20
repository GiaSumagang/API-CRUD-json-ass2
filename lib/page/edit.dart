import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditTodo extends StatefulWidget {
  final todoo;
  const EditTodo({super.key, this.todoo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

class _EditTodoState extends State<EditTodo> {
  TextEditingController titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var id = '';
  var check;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todoo["title"];
    id = widget.todoo["id"].toString();
    check = widget.todoo["title"];
  }

  editData() async {
    var newTitle = titleController.text;
    print(titleController.text);
    var url = Uri.parse('$baseUrl/$id');
    var bodyData = json.encode({
      'title': newTitle,
    });
    var response = await http.patch(url, body: bodyData);
    if (response.statusCode == 200) {
      print('\nSuccessfully edited Data id: $id!');
      var display = response.body;
      print(display);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Title'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(padding: const EdgeInsets.all(20), children: [
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration:
              const InputDecoration(hintText: "Title", labelText: "Title"),
              validator: (value) {
                return (value == '') ? 'Please enter Title' : null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                       editData();
                      check = titleController.text;
                      Navigator.pop(context, check);
                    } else {
                      return;
                    }
                  },
                  child: const Text('Update')),
            ),
          ]),
        ));
  }
}
