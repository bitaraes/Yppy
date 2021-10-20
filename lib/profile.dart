import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_bar/bottom_bar.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/upload.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Cadastrar(),
      '/profile': (context) => Profile(),
      '/upload': (context) => Upload(),
    },
  ));
}

class Profile extends StatefulWidget {
  ProfileState createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.only(left: 60, right: 60)),
                  child: Text(
                    'Meus Dados',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.only(left: 60, right: 60)),
                  child: Text(
                    'Postar História',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.only(left: 60, right: 60)),
                  child: Text(
                    'Configurações',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
