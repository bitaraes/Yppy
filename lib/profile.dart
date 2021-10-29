import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/bottom_bar/bottom_bar.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/upload.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      // bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFF752c98),
                            child: Text(
                              "Photo",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
