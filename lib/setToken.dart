import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

var dio = Dio();

setToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  return token;
}

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

setUser(username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = await getToken();
  String username = prefs.getString('username');
  if (token == null) {
    return token;
  }
  if (token != null && username != null) {
    return [username, token];
  }
}

getPosts() async {
  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwYjdmZTk5NzU1MzExMzI5MDU0NjhhOCIsImlhdCI6MTYzNDI0NDI4NywiZXhwIjoxNjM0ODQ5MDg3fQ.Y4e9VtQcQB-PB86xieek0I8Fk_n4LxZd6H1-bRcMOJo";
  try {
    Response response = await dio.get('http://10.0.2.2:8080/comics',
        options: Options(
            headers: {"Authorization": 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }));
    if (response.statusCode == 200) {
      var list = (response.data as List)
          .map<Widget>((current) => Container(
                child: Container(child: current),
              ))
          .toList();
      return list;
    }
  } on DioError catch (e) {
    print(e);
  }
}
