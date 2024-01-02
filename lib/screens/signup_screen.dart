import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_provider/controlllers/taskmodel.dart';
import 'package:todo_app_with_provider/controlllers/user_Controller.dart';
import 'package:todo_app_with_provider/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserController _userController = UserController();

  final _sharedPreferences = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                var user = _emailController.text;
                var password = _passwordController.text;
                print('user is:${user}');
                print(password);
                _userController.setPassword(user, password, context, false);
              },
              child: const Text('Signup')),
        ],
      ),
    );
  }
}
