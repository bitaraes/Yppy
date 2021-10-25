import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

signin(email, password, context) async {
  var req = await http.post(
    Uri.parse("http://10.0.2.2:8080/auth"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"username": email, "password": password}),
  );
  if (req.statusCode == 200) {
    var response = await json.decode(req.body);
    setUser(response['user']['username'], response['user']['_id']);
    setToken(response['token']);
    Navigator.of(context).pushReplacementNamed('/home');
  } else {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text(
          req.body,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {Navigator.pop(context)},
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}

signup(data, context) async {
  var req = await http.post(
    Uri.parse("http://10.0.2.2:8080/register"),
    body: jsonEncode({
      "email": data['email'],
      "username": data['username'],
      "password": data['password'],
      "rating": 0,
      "description": " ",
      "gender": data['gender']
    }),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (req.statusCode == 200) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Cadastro Efetuado com Sucesso!'),
        content: Text(
          'Clique em ok para fazer login.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {Navigator.of(context).pushReplacementNamed('/')},
            child: Text('Ok'),
          )
        ],
      ),
    );
  } else {
    print(req.statusCode);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text(
          'Ocorreu um erro',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => {Navigator.pop(context)},
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}

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

setUser(username, id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setString('id', id);
}

getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = await getToken();
  String username = prefs.getString('username');
  String id = prefs.getString('id');
  if (token == null) {
    return token;
  }
  if (token != null && username != null) {
    return [username, token, id];
  }
}

getPosts() async {
  var token = await getToken();
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

createPost(file, title, gender, description) async {
  var token = await getToken();
  var user = await getUser();
  var req =
      http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8080/comics'))
        ..fields['title'] = title
        ..fields['gender'] = gender
        ..fields["description"] = description
        ..fields['authorId'] = user[2]
        ..headers['authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('comic', file,
            contentType: MediaType('image', file.toString().split('.').last)));
  req.send().then((value) => print(value.statusCode));
}
