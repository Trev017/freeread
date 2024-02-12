import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/BookModel.dart';
import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';
import '../../services/OnlineService.dart';
import 'FavoritesPage.dart';
import 'DownloadsPage.dart';
import '../BookInformationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  //final ScrollController _scrollController = ScrollController();
  //Temporary method used for displaying books in FutureBuilder
  Future getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

  /*
  Future<String?> getRssImage(String s) async {
    final client = http.Client();
    final response = await client.get(Uri.parse(s));
    final feed = RssFeed.parse(response.body);
    final imageUrl = feed.itunes?.image?.href;
    return imageUrl;
  }
  */

  /*
  Future<List> getAudioList(String s) async {
    await Future.delayed(Duration(seconds: 1));
    List? mp3List = [];
    final client = http.Client();
    final response = await client.get(Uri.parse(s));
    final feed = RssFeed.parse(response.body);
    final List? rssList = feed.items;
    for (int x = 0; x < rssList!.length; x++) {
      RssItem rssElement = rssList.elementAt(x);
      var contentElement = rssElement.media?.contents!.elementAt(0);
      String? mp3url = contentElement?.url;
      mp3List.add(mp3url);
    }
    return mp3List;
  }
  */

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Navigator and MaterialPageRoute ensures that the NavBar persists
    return Navigator(
        onGenerateRoute: (RouteSettings rs) {
          return MaterialPageRoute(
              settings: rs,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Home Page", textAlign: TextAlign.center,),
                      leading: const Icon(Icons.home_outlined),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: Column(
                                children: [
                                  //Navigates to the downloads page
                                  Row(
                                    children: [
                                      Text("Your Downloads"),
                                      const Spacer(),
                                      TextButton (
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadsPage()));
                                        },
                                        child: const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: "More"),
                                              WidgetSpan(child: Icon(Icons.arrow_forward_ios)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Horizontal list builder
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: SizedBox.square(
                                            dimension: 100,
                                            child: FutureBuilder(
                                              future: getRequest(),
                                              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                                                if (snapshot.data == null) {
                                                  return Container(
                                                    padding: const EdgeInsets.all(80),
                                                    child: const Center(
                                                      //child: CircularProgressIndicator(),
                                                      child: Text("Database currently not available"),
                                                    ),
                                                  );
                                                } else {
                                                  return ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (ctx, index) => Card(
                                                      child: SizedBox.square(
                                                        dimension: 140,
                                                        child: ListTile(
                                                          title: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          BookInformationPage(
                                                                            bookId: snapshot.data[index]['id'],
                                                                            bookTitle: snapshot.data[index]['title'],
                                                                            bookDescription: snapshot.data[index]['description'],
                                                                            bookTotalTime: snapshot.data[index]['totaltimesecs'],
                                                                            bookChapters: snapshot.data[index]['sections'],
                                                                            bookAuthor: snapshot.data[index]['authors'],
                                                                          )
                                                                  )
                                                              );
                                                            },
                                                            /*
                                                              icon: Image.network(bookRss),
                                                              label: Text(snapshot.data[index]['title']),
                                                            */
                                                            child: Text(snapshot.data[index]['title']),
                                                            style: ElevatedButton.styleFrom(
                                                              shape: ContinuousRectangleBorder(),
                                                              //backgroundColor: Colors.grey.shade50,
                                                              minimumSize: Size.fromHeight(50),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),
                          Container(
                              child: Column(
                                children: [
                                  //Navigates to the favorites page
                                  Row(
                                    children: [
                                      Text("Your Favorites"),
                                      const Spacer(),
                                      TextButton (
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                                        },
                                        child: const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: "More"),
                                              WidgetSpan(child: Icon(Icons.arrow_forward_ios)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Horizontal list builder
                                      Expanded(
                                          child: SizedBox.square(
                                            dimension: 100,
                                            child: FutureBuilder(
                                              future: getRequest(),
                                              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                                                if (snapshot.data == null) {
                                                  return Container(
                                                    padding: const EdgeInsets.all(80),
                                                    child: const Center(
                                                      //child: CircularProgressIndicator(),
                                                      child: Text("Database currently not available"),
                                                    ),
                                                  );
                                                } else {
                                                  return ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (ctx, index) => Card(
                                                      child: SizedBox.square(
                                                        dimension: 140,
                                                        child: ListTile(
                                                          title: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          BookInformationPage(
                                                                            bookId: snapshot.data[index]['id'],
                                                                            bookTitle: snapshot.data[index]['title'],
                                                                            bookDescription: snapshot.data[index]['description'],
                                                                            bookTotalTime: snapshot.data[index]['totaltimesecs'],
                                                                            bookChapters: snapshot.data[index]['sections'],
                                                                            bookAuthor: snapshot.data[index]['authors'],
                                                                          )
                                                                  )
                                                              );
                                                            },
                                                            /*
                                                              icon: Image.network(bookRss),
                                                              label: Text(snapshot.data[index]['title']),
                                                            */
                                                            child: Text(snapshot.data[index]['title']),
                                                            style: ElevatedButton.styleFrom(
                                                              shape: ContinuousRectangleBorder(),
                                                              //backgroundColor: Colors.grey.shade50,
                                                              minimumSize: Size.fromHeight(50),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}