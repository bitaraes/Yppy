import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter/services.dart';

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

  isVisible() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300), color: Colors.white),
        margin: EdgeInsets.only(bottom: 15),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Image.asset("assets/img/fundo_transparente.png"),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
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
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/tela_de_fundo_app.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isVisible(),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6d398e)),
                                          prefixIcon: Icon(
                                              Icons.account_circle_outlined,
                                              color: Color(0xFF6d398e)),
                                          suffixIcon: IconButton(
                                              onPressed: () =>
                                                  loginController.clear(),
                                              icon: Icon(Icons.clear),
                                              color: Color(0xFF6d398e)),
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
                                          labelStyle: TextStyle(
                                              color: Color(0xFF6d398e)),
                                          prefixIcon: Icon(Icons.lock,
                                              color: Color(0xFF6d398e)),
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                passController.clear(),
                                            icon: Icon(Icons.clear,
                                                color: Color(0xFF6d398e)),
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
                                          if (email == "" || password == "") {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: Text('Erro'),
                                                content: Text(
                                                    'Todos os campos devem ser preenchidos'),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () => {
                                                      Navigator.pop(context)
                                                    },
                                                    child: Text('Ok'),
                                                  )
                                                ],
                                              ),
                                            );
                                          } else {
                                            signin(email, password, context);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF6d398e),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 60, right: 60)),
                                        child: Text(
                                          'Acessar',
                                          style: TextStyle(color: Colors.white),
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
                                          style: TextStyle(
                                              color: Color(0xFF6d398e)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: TextButton(
                                        onPressed: () => {},
                                        child: Text(
                                          'ESQUECI A SENHA',
                                          style: TextStyle(
                                              color: Color(0xFF6d398e)),
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
                            maxHeight: 300,
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
            );
          }
        });
  }
}
