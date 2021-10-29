import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/carousel/carousel.dart';
import 'package:flutter_application_1/components/drawer/drawer.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/upload.dart';
import 'package:flutter_application_1/components/bottom_bar/bottom_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  comicImage(imageUrl) {
    String url = '$api$imageUrl';
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Image.network(url, fit: BoxFit.contain),
        ));
  }

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
                    image: AssetImage("assets/img/fundo_transparente.png"),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/tela_de_fundo_app.jpg'),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            Container(
              height: 180,
              child: Carousel(),
            ),
            FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var postData = snapshot.data
                      .map<Widget>(
                        (e) => Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                          BoxConstraints(maxHeight: 150),
                                      child: comicImage(e['comicUrl']),
                                    ),
                                    Expanded(
                                      child: Container(
                                        constraints:
                                            BoxConstraints(minHeight: 150),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                e['title'],
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                "Autor: " +
                                                    e['author']['username'],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text("Gênero: " +
                                                  e['gender']
                                                      .map((current) =>
                                                          current.toString() +
                                                          " ")
                                                      .toString()
                                                      .replaceAll(
                                                          RegExp("\/D/"), "")),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child:
                                                      Text("Classificação: "),
                                                ),
                                                Container(
                                                  child: RatingBarIndicator(
                                                    rating: double.tryParse(
                                                        e['rating'].toString()),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemSize: 30,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
