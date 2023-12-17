import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/BookModel.dart';
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';
import '../ui/FavoritesPage.dart';
import '../ui/DownloadsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
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
                          Text("Your Downloads"),
                          const Spacer(),
                          TextButton (
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadsPage()));
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: "More", style: TextStyle(color: Colors.black)),
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
                          //
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
                                              title: Text(snapshot.data[index]['title']),
                                              contentPadding: const EdgeInsets.only(bottom: 5),
                                              shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black),),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                          )
                          //
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
                          Text("Your Favorites"),
                          const Spacer(),
                          TextButton (
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: "More", style: TextStyle(color: Colors.black)),
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
                          //
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
                                                title: Text(snapshot.data[index]['title']),
                                                contentPadding: const EdgeInsets.only(bottom: 5),
                                                shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black),),
                                              ),
                                            ),
                                          ),
                                      );
                                    }
                                  },
                                ),
                              )
                          )
                          //
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
}