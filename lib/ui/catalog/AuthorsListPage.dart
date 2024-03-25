import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';

class AuthorsListPage extends StatefulWidget {
  const AuthorsListPage({super.key});

  @override
  State<AuthorsListPage> createState() => _MyAuthorsListPage();
}

class _MyAuthorsListPage extends State<AuthorsListPage> {
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  Future getRequest() async {
    final rp = await dio.get(onlineService.authorsUrl);
    List<Map<String, dynamic>> authors = (rp.data['authors'] as List).map((e) => e as Map<String, dynamic>).toList();
    return authors;
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
          title: const Text("Browse Authors", textAlign: TextAlign.center,),
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
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      /*
                      String firstName = snapshot.data[index]['first_name'];
                      String lastName = snapshot.data[index]['last_name'];
                      */
                      Card(
                        child: SizedBox.square(
                          dimension: 140,
                          child: ListTile(
                            title: Text('${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}'),
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black),),
                          ),
                        ),
                      );
                      /*
                      Card(
                        child: SizedBox.square(
                          dimension: 45,
                          child: ListTile(
                            //
                            title: ElevatedButton(
                              onPressed: () {
                                //
                              },
                              child: Text('${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}'),
                              style: ElevatedButton.styleFrom(
                                shape: ContinuousRectangleBorder(),
                                //backgroundColor: Colors.grey.shade50,
                                minimumSize: Size.fromHeight(50),
                              ),
                            ),
                            //
                          ),
                        ),
                      );
                      */
                    },
                    /*
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    */
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}