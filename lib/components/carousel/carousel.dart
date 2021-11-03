import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api.dart';

void main() => runApp(Carousel());

class Carousel extends StatelessWidget {
  carouselImage(url) {
    Widget image = Image(image: NetworkImage(url));
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> posts = [];
              snapshot.data.map((e) => posts.add(e['comicUrl'])).toString();
              return Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black)),
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                      disableCenter: false, viewportFraction: 0.28),
                  items: posts
                      .map(
                        (e) => Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black)),
                              constraints: BoxConstraints(minHeight: 160),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: carouselImage('$api$e'),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return Container(
              margin: EdgeInsets.all(15),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
