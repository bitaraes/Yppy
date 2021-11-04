import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/carousel/carousel.dart';
import 'package:flutter_application_1/components/comics-dashboard/comics-dashboard.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
