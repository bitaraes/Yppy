import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/setToken.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:dio/dio.dart';

var dio = Dio();

void main() => runApp(MeuAplicativo());

class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context) => Cadastrar(),
        '/profile': (context) => Profile(),
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
  mountUser() async {
    String user = await getUser();
    setState(() {
      username = user;
    });
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF752c98)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Row(
              children: [
                Container(
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/logo_fundoTransparente.png"),
                  ),
                ),
                Container(
                  child: Text(
                    "YPPY",
                    style: TextStyle(
                      color: Color(0xFF752c98),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(height: 180, child: Carousel()),
          FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var postData = snapshot.data
                      .map<Widget>((e) => Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.black,
                                        child: Text(
                                          'Photo',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      child: Text(
                                        e['title'],
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          constraints:
                                              BoxConstraints(maxHeight: 250),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image(
                                                  image: NetworkImage(
                                                      'https://images-na.ssl-images-amazon.com/images/S/cmx-images-prod/Item/712988/712988._SX1600_QL80_TTD_.jpg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        e['description'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                      .toList();
                  return Column(
                    children: postData,
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.all(15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })
        ],
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_sharp,
                  color: Color(0xFF752c98),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search_sharp,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.library_add_sharp,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_sharp),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.person_sharp,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Ocorreu um erro");
          }

          if (snapshot.hasData) {
            return ListView(
              children: [
                // ignore: missing_required_param
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF752c98),
                  ),
                  accountName: Text(snapshot.data[0].replaceFirst(
                      snapshot.data[0][0], snapshot.data[0][0].toUpperCase())),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      snapshot.data[0][0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  subtitle: Text("Ir para Home"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    print('Voltar para o Inicio.');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text("Perfil"),
                  subtitle: Text("Siga para ver o seu perfil."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    print('Ir para postagens.');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  subtitle: Text("Faça Logout"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    logout();
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            );
          } else {
            return ListView(
              children: [
                // ignore: missing_required_param
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF752c98),
                  ),
                  accountName: Text("YPPYVERSE"),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white, child: Text("Y")),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  subtitle: Text("Ir para Home"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    print('Voltar para o Inicio.');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Login"),
                  subtitle: Text("Faça Login"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Cadastrar"),
                  subtitle: Text("Crie uma conta"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            );
          }
        });
  }

  mountMenu(BuildContext context) {}
}

// ignore: must_be_immutable
class Carousel extends StatelessWidget {
  var _listSlide = [
    'https://www.hdwallpapers.net/previews/spiderman-logo-629.jpg',
    'https://www.hdwallpapers.net/previews/guardians-of-the-galaxy-628.jpg',
    'https://www.hdwallpapers.net/previews/the-flash-622.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: CarouselSlider(
        options: CarouselOptions(enlargeCenterPage: true),
        items: _listSlide
            .map(
              (e) => Container(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 160),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image(image: NetworkImage(e), fit: BoxFit.cover)),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
