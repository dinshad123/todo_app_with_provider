import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_provider/controlllers/todoModelView.dart';
import 'package:todo_app_with_provider/screens/todo_editscreen.dart';

class TodoListScreen extends StatelessWidget {
  String? token;
  TodoListScreen({this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TodoEditScreen()));
          }),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Consumer<TodoModelView>(
                builder: (context, value, child) {
                  return FutureBuilder(
                      future: value.getTodoData(token!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // If the Future is still in progress, show a loading indicator.
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data == null) {
                          return const Center(
                            child: Text('No data available'),
                          );
                        } else {
                          List data = snapshot.data!;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading:
                                      Text(data[index]['title'] ?? 'no title'),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Provider.of<TodoModelView>(context,
                                              listen: false)
                                          .deleteTodoData(data[index]['_id']);
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                );
                              });
                        }
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
