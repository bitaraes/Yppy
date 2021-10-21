import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNmYwZjFiYjA5ODQ1MGFkNGY4YzJmYyIsImlhdCI6MTYzNDg1NTQ3OCwiZXhwIjoxNjM1NDYwMjc4fQ.VVbBBBSkENHNMMVgFfxey4P06sNUoSxg4-lOLHvbWGc";
  try {
    var response = await http.get(
      Uri.http('10.0.2.2:8080', '/comics'),
      headers: {"Authorization": 'Bearer $token'},
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return json;
    } else {
      print(response.statusCode);
      print('Ocorreu um erro');
    }
  } catch (e) {
    print(e);
  }
}
