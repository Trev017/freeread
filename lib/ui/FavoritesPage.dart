import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<FavoritesPage> {
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
          title: const Text("Favorites Page", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: BackButton(),
              onTap: () {
                Navigator.pop(context);
              }
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
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
                            dimension: 140,
                            child: ListTile(
                              title: Text(snapshot.data[index]['title']),
                              contentPadding: const EdgeInsets.only(bottom: 5),
                              shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black),),
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