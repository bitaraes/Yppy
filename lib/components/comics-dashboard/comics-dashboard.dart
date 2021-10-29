import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_application_1/services/api.dart';
import 'package:flutter/material.dart';

void main() => runApp(ComicDashboard());

class ComicDashboard extends StatelessWidget {
  comicImage(imageUrl, context) {
    String url = '$api$imageUrl';
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Image.network(url, fit: BoxFit.contain),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                              constraints: BoxConstraints(maxHeight: 150),
                              child: comicImage(e['comicUrl'], context),
                            ),
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(minHeight: 150),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        e['title'],
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Autor: " + e['author']['username'],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text("Gênero: " +
                                          e['gender']
                                              .map((current) =>
                                                  current.toString() + " ")
                                              .toString()
                                              .replaceAll(
                                                  RegExp("[/\(\)]"), "")),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Text("Classificação: "),
                                        ),
                                        Container(
                                          child: RatingBarIndicator(
                                            rating: double.tryParse(
                                                e['rating'].toString()),
                                            itemBuilder: (context, index) =>
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
    );
  }
}
