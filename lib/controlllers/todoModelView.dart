import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_with_provider/model/todoModel.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_with_provider/router/router_address_config.dart';

class TodoModelView with ChangeNotifier, DiagnosticableTreeMixin {
  List<TodoModel> taskList = [];

  void addTodoList(String title) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    var token = _sharedPreferences.getString('token');
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    var userid = decodedToken['_id'];
    String decriptionData = "anything";
    var regbody = {'title': title, 'desc': decriptionData, 'userId': userid};
    print(regbody);
    var response = await http.post(Uri.parse(addTodoAdress),
        body: jsonEncode(regbody),
        headers: {"Content-Type": "application/json"});
    var jsonRespone = jsonDecode(response.body);
    if (jsonRespone['status']) {
      print('data added successfully');
    }
    TodoModel _todoModel = TodoModel(title);

    taskList.add(_todoModel);
    notifyListeners();
  }

  Future<List> getTodoData(String token) async {
    List tokendata = [];
    // final SharedPreferences _sharedPreferences =
    //     await SharedPreferences.getInstance();
    // var token = _sharedPreferences.getString('token');
    print(token);
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var userId = decodedToken['_id'];
    print(userId);
    var regbody = {'userId': userId};
    var response = await http.post(Uri.parse(getTodoAddress),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody));
    if (response.statusCode == 200) {
      var jwtResponse = jsonDecode(response.body);
      tokendata = jwtResponse['success'];
    }
    // notifyListeners();
    print(tokendata);
    return tokendata;
  }

  void deleteTodoData(String id) async {
    var regbody = {'id': id};
    var response = await http.post(Uri.parse(deletTodoAddress),
        body: jsonEncode(regbody),
        headers: {"Content-Type": "application/json"});
    var jsonresponse = jsonDecode(response.body);
    if (jsonresponse['status']) {
      notifyListeners();
    }
  }
}
