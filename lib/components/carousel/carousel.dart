import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api.dart';

void main() => runApp(Carousel());

class Carousel extends StatelessWidget {
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
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: CarouselSlider(
                  options: CarouselOptions(
                      disableCenter: false, viewportFraction: 0.30),
                  items: posts
                      .map(
                        (e) => Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              constraints: BoxConstraints(minHeight: 160),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                      image: NetworkImage('$api$e'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return Container();
          }),
    );
  }
}
