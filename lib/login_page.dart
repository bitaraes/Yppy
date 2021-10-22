import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/setToken.dart';
import 'package:flutter_application_1/signup.dart';

var dio = Dio();
String email = "";
String password = "";
void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/signup': (context) => Cadastrar(),
    },
  ));
}

class Login extends StatefulWidget {
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  login() async {
    try {
      Response response = await dio.post("http://10.0.2.2:8080/auth",
          data: {"username": email, "password": password},
          options: Options(method: 'POST', contentType: 'application/json'));
      loginController.clear();
      passController.clear();
      email = " ";
      password = " ";
      String token = response.data['token'];
      String username = response.data["user"]["username"];
      setUser(username);
      setToken(token);
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } on DioError catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text(
            e.response.data,
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

  isVisible() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Image.asset("assets/yppy-logo.png"),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 25),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background-roxo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isVisible(),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceAround,
                                    runSpacing: 15,
                                    spacing: 10,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.37,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Facebook'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue[800],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.37,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('Google'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red[400],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'ou',
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: TextField(
                                          controller: loginController,
                                          onChanged: (text) {
                                            email = text;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            labelText: 'Login',
                                            prefixIcon: Icon(
                                                Icons.account_circle_outlined),
                                            suffixIcon: IconButton(
                                              onPressed: () =>
                                                  loginController.clear(),
                                              icon: Icon(Icons.clear),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: TextField(
                                          controller: passController,
                                          onChanged: (text) {
                                            password = text;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            labelText: 'Senha',
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                              onPressed: () =>
                                                  passController.clear(),
                                              icon: Icon(Icons.clear),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 15,
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            login();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.yellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: 60, right: 60)),
                                          child: Text(
                                            'Acessar',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.spaceAround,
                                    spacing: 20,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: TextButton(
                                          onPressed: () => {
                                            Navigator.pushNamed(
                                                context, '/signup')
                                          },
                                          child: Text(
                                            'CRIAR CONTA',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: TextButton(
                                          onPressed: () => {},
                                          child: Text(
                                            'ESQUECI A SENHA',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 250,
                              maxHeight: 440,
                              maxWidth: 450,
                            ),
                            height: MediaQuery.of(context).size.height * 0.60,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black,
                                width: 5,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
