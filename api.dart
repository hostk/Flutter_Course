import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(Myapp());
}

class News {
  final String title;
  final String description;
  final String author;
  final String urlToImage;

  News(this.title, this.description, this.author, this.urlToImage);
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<News>> getNews() async {
    var data = await http.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=e1507292a3924ba598cfad5d491083a4');

    var jsonData = json.decode(data.body);
    var newsData = jsonData['articles'];
    List<News> news = [];

    for (var data in newsData) {
      News newsItem = News(data['title'], data['description'], data['author'],
          data['urlToImage']);
      news.add(newsItem);
    }
    return news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getNews(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              News news = News(
                                snapshot.data[index].title,
                                snapshot.data[index].description,
                                snapshot.data[index].author,
                                snapshot.data[index].urlToImage,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            news: news,
                                          )));
                            },
                            child: Card(
                                child: Column(children: [
                              snapshot.data[index].urlToImage == null
                                  ? Image.network("")
                                  : Image.network(
                                      snapshot.data[index].urlToImage,
                                      fit: BoxFit.cover),
                              ListTile(
                                title: Text(
                                  snapshot.data[index].title,
                                ),
                              ),
                            ])));
                      });
                }
              })),
    );
  }
}

class Details extends StatelessWidget {
  final News news;

  const Details({this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  child: Image.network(
                    news.urlToImage,
                    fit: BoxFit.cover,
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    news.title,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        letterSpacing: 0.2,
                        wordSpacing: 0.6,
                        fontWeight: FontWeight.bold),
                  )),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        "Author : " + news.author,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                  Text(
                    news.description,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
