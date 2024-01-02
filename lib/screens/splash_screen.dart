import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_provider/controlllers/todoModelView.dart';
import 'package:todo_app_with_provider/screens/login_screen.dart';
import 'package:todo_app_with_provider/screens/signup_screen.dart';
import 'package:todo_app_with_provider/screens/todo_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      var token = _sharedPreferences.getString('token');
      Provider.of<TodoModelView>(context, listen: false).getTodoData(token!);
      if (token == null || JwtDecoder.isExpired(token)) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return TodoListScreen(
            token: token,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Provider TODO",
        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
      )),
    );
  }
}
