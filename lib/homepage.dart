import 'package:flutter/material.dart';
import 'package:gia/page/addtodo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'page/edit.dart';
import 'page/todo_details.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key, required String home}) : super(key: key);

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  List todos = <dynamic>[];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  //READ
  fetchData() async {
    var response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    setState(() {
      todos = convert.jsonDecode(response.body);
    });
  }


  //DELETE
  deleteData(var todo) async {
    var response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo['id']}'));

    if (response.statusCode == 200) {
      showSuccessMessage('Deleted Successfully');
      setState(() {
        todos.remove(todo);
      });
    } else {
      showErrorMessage('Request failed with a status: ${response.statusCode}');
      throw Exception('Failed to delete todo');
    }
  }

  displayEditedData(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
            'Successfully edited Title: ${object["title"]} ID: ${object["id"]}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('Todo List')),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.1, horizontal: 10.5),
                  child: ListTile(
                      leading: Checkbox(
                        value: todo['completed'],
                        onChanged: (bool? newValue) {
                          setState(() {
                            todo['completed'] = newValue!;
                          });
                        },
                      ),
                      title: Text(
                        todo['title'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: (() async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditTodo(todoo: todo)));
                                  if (result != null) {
                                    setState(() {
                                      todos[index]['title'] = result;
                                    });
                                    displayEditedData(todo[index]);
                                  } else {
                                    print('No Changes');
                                  }
                                }),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: (() {
                                  deleteData(todo);
                                }),
                              ),
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TodoDetails(todo: todos[index])));
                      }));
            }),
        backgroundColor: const Color.fromARGB(255, 248, 246, 255),
        floatingActionButton: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: const Icon(Icons.add),
            onPressed: () async {
              var newUser = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddList(data: todos)));
              setState(() {
                todos.add(newUser) as List <dynamic>;
              });
            }));
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
