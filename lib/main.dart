import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/upload.dart';
import 'package:flutter_application_1/components/drawer/drawer.dart';
import 'package:flutter/services.dart';

void main() => runApp(MeuAplicativo());

class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Acme'),
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/signup': (context) => Cadastrar(),
        '/profile': (context) => Profile(),
        '/upload': (context) => Upload(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String username = "";
  int _indiceAtual = 0;
  int _barMovement = 0;
  List<Widget> pages = [
    HomePage(),
    Upload(),
    Profile(),
  ];
  mountUser() async {
    String user = await getUser();
    setState(() {
      username = user;
    });
    return username;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      drawer: Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFffffff)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      color: Colors.white),
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/img/fundo_transparente.png"),
                  ),
                ),
              ],
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF23D4D2),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/tela_de_fundo_app.jpg'),
              fit: BoxFit.cover),
        ),
        child: pages[_indiceAtual],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFF23D4D2)),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              AnimatedContainer(
                transform: Matrix4.translationValues(
                    MediaQuery.of(context).size.width * (_barMovement * 0.2),
                    0,
                    0),
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(color: Color(0xFFed1d7f)),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _indiceAtual = 0;
                        _barMovement = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _barMovement = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.library_add_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _indiceAtual = 1;
                        _barMovement = 2;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications_sharp),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _barMovement = 3;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_sharp,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _indiceAtual = 2;
                        _barMovement = 4;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
