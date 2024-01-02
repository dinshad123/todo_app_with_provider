import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/controlllers/todoModelView.dart';
import 'package:todo_app_with_provider/screens/todo_list_screen.dart';

class TodoEditScreen extends StatelessWidget {
  TodoEditScreen({super.key});
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () {
                TodoModelView _todoModelView =
                    Provider.of<TodoModelView>(context, listen: false);
                _todoModelView.addTodoList(_titleController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TodoListScreen();
                }));
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
