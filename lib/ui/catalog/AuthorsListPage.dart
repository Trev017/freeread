import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
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
    authors.length;
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
                  int il = snapshot.data!.length;
                  //il = 6426;
                  return ListView.builder(
                    itemCount: il == null ? 0 : 50,
                    itemBuilder: (ctx, index) {
                      /*
                      String firstName = snapshot.data[index]['first_name'];
                      String lastName = snapshot.data[index]['last_name'];
                      */
                      /*
                      Card(
                        child: SizedBox.square(
                          dimension: 140,
                          child: ListTile(
                            title: Text('${snapshot.data![index]['first_name']} ${snapshot.data![index]['last_name']}'),
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black),),
                          ),
                        ),
                      );
                      */
                      //
                      Card(
                        child: SizedBox.square(
                          dimension: 45,
                          child: ListTile(
                            //
                            title: ElevatedButton(
                              onPressed: () {
                                //
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                //backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: Text('${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}'),
                            ),
                            //
                          ),
                        ),
                      );
                      return null;
                      //
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