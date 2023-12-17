import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';
import '../ui/RecommendationsPage.dart';
import '../ui/BooksListPage.dart';
import '../ui/AuthorsListPage.dart';
import '../ui/GenresListPage.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _MyCatalogPageState();
}

class _MyCatalogPageState extends State<CatalogPage> {
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
                      Row(
                        children: [
                          Text("Recommended"),
                          const Spacer(),
                          TextButton (
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationsPage()));
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
                                            //subtitle: Text(snapshot.data[index]['description']),
                                            //contentPadding: const EdgeInsets.only(bottom: 20),
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
              //const Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BooksListPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.grey.shade50,
                    minimumSize: Size.fromHeight(90),
                  ),
                  child: const Text ("Browse All Books", style: TextStyle(color: Colors.black)),
                ),
              ),
              //const Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorsListPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.grey.shade50,
                    minimumSize: Size.fromHeight(90),
                  ),
                  child: const Text ("Browse Authors", style: TextStyle(color: Colors.black)),
                ),
              ),
              //const Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GenresListPage()));
                  },
                  style: OutlinedButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.grey.shade50,
                    minimumSize: Size.fromHeight(90),
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
}