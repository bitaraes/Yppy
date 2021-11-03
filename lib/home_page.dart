import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/carousel/carousel.dart';
import 'package:flutter_application_1/components/comics-dashboard/comics-dashboard.dart';
import 'package:flutter_application_1/components/drawer/drawer.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 1,
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
            ComicDashboard(),
          ],
        ),
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
    );
  }
}
