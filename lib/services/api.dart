import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

var api = "https://comics-yppy.herokuapp.com";

signin(email, password, context) async {
  var req = await http.post(
    Uri.parse(api + "/auth"),
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
    Uri.parse(api + "/register"),
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
  String token = await getToken();
  String url = api + '/comics';
  try {
    var response = await http.get(
      Uri.parse(url),
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

createPost(file, title, gender, description, context) async {
  var token = await getToken();
  try {
    var req = http.MultipartRequest('POST', Uri.parse(api + '/comics'))
      ..fields['title'] = title
      ..fields['gender'] = gender
      ..fields["description"] = description
      ..fields['rating'] = "5"
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(http.MultipartFile.fromBytes('comic', file[0],
          contentType: MediaType('image', file.toString().split('.').last),
          filename: file[1]));
    req.send().then(
          (response) => {
            if (response.statusCode == 200)
              {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Sucesso',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'Sua história foi publicada com sucesso!',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pushReplacementNamed('/home')
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                ),
              }
            else
              {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Erro',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'Aconteceu um erro durante a postagem, tente novamente mais tarde',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                ),
              },
          },
        );
  } catch (e) {
    print(e);
  }
}

Future<int> findImage(url) async {
  var response = await http.get(Uri.parse(url));
  return response.statusCode;
}
