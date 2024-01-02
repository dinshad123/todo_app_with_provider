import 'package:flutter/material.dart';
import 'package:todo_app_with_provider/controlllers/taskmodel.dart';
import 'package:todo_app_with_provider/controlllers/user_Controller.dart';
import 'package:todo_app_with_provider/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserController _userController = UserController();
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
                _userController.setPassword(user, password, context, true);
              },
              child: const Text('Log in')),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignupScreen();
                }));
              },
              child: const Text("Dont have an account?"))
        ],
      ),
    );
  }
}
