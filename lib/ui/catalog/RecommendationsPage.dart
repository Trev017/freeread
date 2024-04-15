import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({super.key});

  @override
  State<RecommendationsPage> createState() => _MyRecommendationsPageState();
}

class _MyRecommendationsPageState extends State<RecommendationsPage> {
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
    return SafeArea(
      child: Scaffold (
        appBar: AppBar(
          title: const Text("Recommended", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: const BackButton(),
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
                } else if (snapshot.hasError && snapshot.error is SocketException) {
                  return Container(
                    child: const Center(
                      child: Text("Please connect to the Internet"),
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