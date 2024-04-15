import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';
import '../../model/BookModelClass.dart';
import '../../model/BookModelMethods.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _MyDownloadsPageState();
}

class _MyDownloadsPageState extends State<DownloadsPage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  final BookModelMethods bookModelMethods = BookModelMethods();
  List<BookModel> books = [];
  //Temporary method used for displaying books in FutureBuilder
  Future getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

  void getHiveBooks() async {
    var booksData = await bookModelMethods.getBookList();
    books.addAll(booksData);
  }

  @override
  void initState() {
    getRequest();
    getHiveBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        appBar: AppBar(
          title: const Text("Downloads Page", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: const BackButton(),
              onTap: () {
                Navigator.pop(context);
              }
          ),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Edit Your Database"),
                      //content: const Text("Delete All Entries"),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete All Entries"),
                                        content: const Text("This action is irreversible. Would you like to continue?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              bookModelMethods.deleteAll();
                                              Navigator.pop(context, 'Confirm');
                                            },
                                            child: const Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                        ],
                                        actionsAlignment: MainAxisAlignment.center,
                                      );
                                    }
                                );
                                //Navigator.pop(context, 'Proceed');
                              },
                              child: const Text("Delete All Entries"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Exit');
                              },
                              child: const Text("Exit"),
                            ),
                          ],
                        ),
                      ],
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                    );
                  },
                );
              },
              child: const Text("Edit",),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          //Vertical list builder
          child: FutureBuilder(
              future: bookModelMethods.getBookList(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false || bookModelMethods.containsBooks() == false || snapshot.data == null) {
                  return Container(
                    child: const Center(
                      child: Text("Database currently empty. Mark a book as your favorite."),
                    ),
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: SizedBox.square(
                          dimension: 45,
                          child: ListTile(
                            //
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
                            //
                          ),
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}