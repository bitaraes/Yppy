import 'package:flutter/material.dart';

void main() => runApp(BottomBar());

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_sharp,
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
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
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
    );
  }
}
