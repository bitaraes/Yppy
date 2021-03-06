import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter/services.dart';

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
  var data = {
    "email": '',
    "username": '',
    "password": '',
    "rating": 0,
    "description": " ",
    "gender": 'Masculino'
  };

  isVisible() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300), color: Colors.white),
        margin: EdgeInsets.only(bottom: 10),
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
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'Crie uma conta',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: userController,
                                  onChanged: (text) {
                                    data['username'] = text;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Nome de Usu??rio',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF6d398e)),
                                    prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                        color: Color(0xFF6d398e)),
                                    suffixIcon: IconButton(
                                      onPressed: () => userController.clear(),
                                      icon: Icon(Icons.clear,
                                          color: Color(0xFF6d398e)),
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
                                    data['email'] = text;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF6d398e)),
                                    prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                        color: Color(0xFF6d398e)),
                                    suffixIcon: IconButton(
                                      onPressed: () => emailController.clear(),
                                      icon: Icon(Icons.clear,
                                          color: Color(0xFF6d398e)),
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
                                    data['password'] = text;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF6d398e)),
                                    prefixIcon: Icon(Icons.lock,
                                        color: Color(0xFF6d398e)),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          passwordController.clear(),
                                      icon: Icon(Icons.clear,
                                          color: Color(0xFF6d398e)),
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
                                          groupValue: data['gender'],
                                          onChanged: (T) {
                                            setState(() {
                                              data['gender'] = T;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Masculino',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: "Feminino",
                                          groupValue: data['gender'],
                                          onChanged: (T) {
                                            setState(() {
                                              data['gender'] = T;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Feminino',
                                        ),
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
                                    if (data['email'] != "" ||
                                        data['username'] != "" ||
                                        data['password'] != "") {
                                      signup(data, context);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Erro'),
                                          content: Text(
                                              'Todos os campos devem ser preenchidos'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  {Navigator.pop(context)},
                                              child: Text('Ok'),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF6d398e),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 60, right: 60)),
                                  child: Text(
                                    'Criar Conta',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () => {Navigator.pop(context)},
                              child: Text(
                                "Ou Fa??a Login",
                              ),
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
