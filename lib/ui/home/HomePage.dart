import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import 'FavoritesPage.dart';
import 'DownloadsPage.dart';
import '../BookInformationPage.dart';
import '../../model/BookModelClass.dart';
import '../../model/BookModelMethods.dart';
//Class to display the home page.
class HomePage extends StatefulWidget {

  //Class constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  final BookModelMethods bookModelMethods = BookModelMethods();
  List<BookModel> books = [];
  /*
  Future getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }
  */

  //Gets all books in the Hive box.
  void getHiveBooks() async {
    var booksData = await bookModelMethods.getBookList();
    books.addAll(booksData);
  }

  @override
  void initState() {
    //getRequest();
    getHiveBooks();
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
                                  Row(
                                    children: [
                                      const Text("Your Downloads"),
                                      const Spacer(),
                                      TextButton (
                                        //Redirects the user to the downloads page.
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DownloadsPage()));
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
                                              future: bookModelMethods.getBookList(),
                                              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                                                if (snapshot.data == null) {
                                                  //Displays an error to indicate that the box is empty.
                                                  return Container(
                                                    padding: const EdgeInsets.all(80),
                                                    child: const Center(
                                                      child: Text("Database currently empty. Mark a book as your favorite."),
                                                    ),
                                                  );
                                                } else {
                                                  //Displays a list of books.
                                                  return ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (ctx, index) {
                                                      return Card(
                                                        child: SizedBox.square(
                                                          dimension: 140,
                                                          child: ListTile(
                                                            //Redirects the user to the book information page.
                                                            title: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) {
                                                                          return BookInformationPage(
                                                                            bookId: snapshot.data[index].id,
                                                                            bookTitle: snapshot.data[index].title,
                                                                            bookDescription: snapshot.data[index].description,
                                                                            bookLanguage: snapshot.data[index].language,
                                                                            bookYear: snapshot.data[index].copyright_year,
                                                                            bookRss: snapshot.data[index].url_rss,
                                                                            bookTotalTime: snapshot.data[index].totaltimesecs,
                                                                            bookChapters: snapshot.data[index].chapters,
                                                                            bookAuthor: snapshot.data[index].author,
                                                                          );
                                                                        }
                                                                    )
                                                                );
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                shape: const ContinuousRectangleBorder(),
                                                                //backgroundColor: Colors.grey.shade50,
                                                                minimumSize: const Size.fromHeight(50),
                                                              ),
                                                              child: Text(snapshot.data[index].title),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
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
                                  Row(
                                    children: [
                                      const Text("Your Favorites"),
                                      const Spacer(),
                                      TextButton (
                                        //Redirects the user to the favorites page.
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
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
                                              future: bookModelMethods.getBookList(),
                                              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                                                if (snapshot.data == null) {
                                                  //Displays an error to indicate that the box is empty.
                                                  return Container(
                                                    padding: const EdgeInsets.all(80),
                                                    child: const Center(
                                                      child: Text("Database currently empty. Mark a book as your favorite."),
                                                    ),
                                                  );
                                                } else {
                                                  //Displays a list of books.
                                                  return ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: snapshot.data.length,
                                                      itemBuilder: (ctx, index) {
                                                        return Card(
                                                          child: SizedBox.square(
                                                            dimension: 140,
                                                            child: ListTile(
                                                              //Redirects the user to the book information page.
                                                              title: ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) {
                                                                            return BookInformationPage(
                                                                              bookId: snapshot.data[index].id,
                                                                              bookTitle: snapshot.data[index].title,
                                                                              bookDescription: snapshot.data[index].description,
                                                                              bookLanguage: snapshot.data[index].language,
                                                                              bookYear: snapshot.data[index].copyright_year,
                                                                              bookRss: snapshot.data[index].url_rss,
                                                                              bookTotalTime: snapshot.data[index].totaltimesecs,
                                                                              bookChapters: snapshot.data[index].chapters,
                                                                              bookAuthor: snapshot.data[index].author,
                                                                            );
                                                                          }
                                                                      )
                                                                  );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  shape: const ContinuousRectangleBorder(),
                                                                  //backgroundColor: Colors.grey.shade50,
                                                                  minimumSize: const Size.fromHeight(50),
                                                                ),
                                                                child: Text(snapshot.data[index].title),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
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