import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:dio/dio.dart';

var dio = Dio();

void main() => runApp(
      MaterialApp(
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Home(),
          '/signup': (context) => Cadastrar(),
        },
      ),
    );

class Cadastrar extends StatefulWidget {
  CadastrarState createState() {
    return CadastrarState();
  }
}

class CadastrarState extends State<Cadastrar> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String user = "";
  String email = "";
  String password = "";
  String gender = "Masculino";

  signup() async {
    try {
      Response response = await dio.post(
        "http://10.0.2.2:8080/register",
        data: {
          "email": email,
          "username": user,
          "password": password,
          "rating": 0,
          "description": " ",
          "gender": gender
        },
        options: Options(contentType: 'application/json'),
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Cadastro Efetuado com Sucesso!'),
            content: Text(
              'Clique em ok para fazer login.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, '/login')},
                child: Text('Ok'),
              )
            ],
          ),
        );
      }
    } on DioError catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text(
            e.response.data["error"],
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
        height: MediaQuery.of(context).size.height * 0.20,
        child: Image.asset("assets/yppy-logo.png"),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'Crie uma conta',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: userController,
                                  onChanged: (text) {
                                    user = text;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Nome de Usuário',
                                    prefixIcon:
                                        Icon(Icons.account_circle_outlined),
                                    suffixIcon: IconButton(
                                      onPressed: () => userController.clear(),
                                      icon: Icon(Icons.clear),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: emailController,
                                  onChanged: (text) {
                                    email = text;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon:
                                        Icon(Icons.account_circle_outlined),
                                    suffixIcon: IconButton(
                                      onPressed: () => emailController.clear(),
                                      icon: Icon(Icons.clear),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: passwordController,
                                  onChanged: (text) {
                                    password = text;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          passwordController.clear(),
                                      icon: Icon(Icons.clear),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: "Masculino",
                                          groupValue: gender,
                                          onChanged: (T) {
                                            setState(() {
                                              gender = T;
                                            });
                                          },
                                        ),
                                        Text('Masculino'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: "Feminino",
                                          groupValue: gender,
                                          onChanged: (T) {
                                            setState(() {
                                              gender = T;
                                            });
                                          },
                                        ),
                                        Text('Feminino'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    signup();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.yellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 60, right: 60)),
                                  child: Text(
                                    'Criar Conta',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: Text("Ou Faça Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxHeight: 440,
                      maxWidth: 450,
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.65,
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
}
