import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import 'RecommendationsPage.dart';
import 'BooksListPage.dart';
import 'AuthorsListPage.dart';
import 'GenresListPage.dart';
import '../BookInformationPage.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _MyCatalogPageState();
}

class _MyCatalogPageState extends State<CatalogPage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  //Temporary method used for displaying books in FutureBuilder
  Future getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

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
                  child: Scaffold (
                    appBar: AppBar(
                      title: const Text("Catalog Page", textAlign: TextAlign.center,),
                      leading: const Icon(Icons.menu_book),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: Column(
                                children: [
                                  //Navigates to the downloads page
                                  Row(
                                    children: [
                                      const Text("Recommended"),
                                      const Spacer(),
                                      TextButton (
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendationsPage()));
                                        },
                                        child: const Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: "More",),
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
                                                    //controller: _scrollController,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (ctx, index) => Card(
                                                      child: SizedBox.square(
                                                        dimension: 150,
                                                        child: ListTile(
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
                                                                        bookLanguage: snapshot.data[index]['language'],
                                                                        bookYear: snapshot.data[index]['copyright_year'],
                                                                        bookRss: snapshot.data[index]['url_rss'],
                                                                        bookTotalTime: snapshot.data[index]['totaltimesecs'],
                                                                        bookChapters: snapshot.data[index]['sections'],
                                                                        bookAuthor: snapshot.data[index]['authors'],
                                                                      )
                                                                  )
                                                              );
                                                              },
                                                            style: ElevatedButton.styleFrom(
                                                              shape: const ContinuousRectangleBorder(),
                                                              //backgroundColor: Colors.grey.shade50,
                                                              minimumSize: const Size.fromHeight(50),
                                                            ),
                                                            child: Text(snapshot.data[index]['title']),
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
                          //Navigates to the browse all page
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BooksListPage()));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(90),
                              ),
                              child: const Text ("Browse All Books", style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          //Navigates to the browse authors page
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthorsListPage()));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(90),
                              ),
                              child: const Text ("Browse Authors", style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          //Navigates to the browse genres page
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const GenresListPage()));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(90),
                              ),
                              child: const Text ("Browse Genres", style: TextStyle(color: Colors.black)),
                            ),
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