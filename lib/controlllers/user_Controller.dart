import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_provider/controlllers/todoModelView.dart';
import 'package:todo_app_with_provider/router/router_address_config.dart';
import 'package:todo_app_with_provider/screens/login_screen.dart';
import 'package:todo_app_with_provider/screens/todo_list_screen.dart';

class UserController {
  // String? userName;
  // String? password;
  // UserController(this.userName, this.password);
  void setPassword(String userName, String password, BuildContext context,
      bool isRegistered) async {
    BuildContext? localContext = context;
    var uriBase = isRegistered ? login : registartion;
    var regBody = {'email': userName, 'password': password};
    var response = await http.post(Uri.parse(uriBase),
        body: jsonEncode(regBody),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // jsonResponse['token'] contains a map of data here i am coverting the whole map into a single string
        String myToken = jsonResponse['token'];

        SharedPreferences _sharedPreferences =
            await SharedPreferences.getInstance();
        _sharedPreferences.setString('token', myToken);
      }
      if (jsonResponse['status'] && isRegistered == false) {
        Navigator.push(localContext,
            MaterialPageRoute(builder: (BuildContext context) {
          return LoginScreen();
        }));
      } else if (jsonResponse['status'] && isRegistered) {
        Navigator.push(localContext,
            MaterialPageRoute(builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) {
              TodoModelView();
            },
            child: TodoListScreen(),
          );
          // TodoListScreen();
        }));
      }
    } else {
      ScaffoldMessenger.of(localContext)
          .showSnackBar!(const SnackBar(content: Text('an error occured')));
    }
  }
}
