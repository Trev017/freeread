import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _MyBooksListPageState();
}

class _MyBooksListPageState extends State<BooksListPage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
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
    return SafeArea(
      child: Scaffold (
        appBar: AppBar(
          title: const Text("Browse All", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: BackButton(),
              onTap: () {
                Navigator.pop(context);
              }
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          //Vertical list builder
          child: FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: const Center(
                      //child: CircularProgressIndicator(),
                      child: Text("Database currently not available"),
                    ),
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) => Card(
                      child: SizedBox.square(
                        dimension: 45,
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
                          //
                        ),
                      ),
                    ),
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