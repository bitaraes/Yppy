import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
