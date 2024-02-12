import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MySearchPage();
}

class _MySearchPage extends State<SearchPage> {
  TextEditingController filter = TextEditingController();
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  String searchText = "";
  //Method to perform a GET request to initially build a list
  Future getBooksRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }
  //Method to perform a GET request with a specified query
  Future getBooksbyTitleRequest(String q) async {
    String s = onlineService.booksUrl;
    final rp = await dio.get("$s&title=^$q");
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

  pageState() {
    filter.addListener(() {
      if (filter.text.isEmpty) {
        setState(() {
          searchText = "";
        });
      } else {
        setState(() {
          searchText = filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    getBooksRequest();
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
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Search Page", textAlign: TextAlign.center,),
                  leading: const Icon(Icons.search),
                ),
                body: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          onChanged: (v) {
                            setState(() {
                              searchText = v;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Search",
                            suffixIcon: Icon(Icons.search),
                          ),
                        )),
                    Expanded(
                      child: FutureBuilder(
                        future: getBooksbyTitleRequest(searchText),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Center(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (ctx, index) {
                                    /*
                                    String s = snapshot.data[index]['url_rss'];
                                    final rp = await dio.get(snapshot.data[index]['url_rss']);
                                    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
                                    */
                                    //final rssString = dio.get(snapshot.data[index]['url_rss']);
                                    if (snapshot.data[index]['title']
                                        .contains(searchText)) {
                                      //
                                      return ListTile(
                                        //title: Text(snapshot.data[index]['title']));
                                        //
                                        title: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BookInformationPage(
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
                                          child: Text(snapshot.data[index]['title']),
                                          style: ElevatedButton.styleFrom(
                                            shape: ContinuousRectangleBorder(),
                                            //backgroundColor: Colors.grey.shade50,
                                            minimumSize: Size.fromHeight(50),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            );
                            //Displays if search result is incorrect
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("No results"));
                            //Displays if connection is unavailable
                          } else if (snapshot.data == null) {
                            return Center(child: Text("Database currently not available"));
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
                //resizeToAvoidBottomInset: false,
              );
            }
          );
        }
    );
  }
}
