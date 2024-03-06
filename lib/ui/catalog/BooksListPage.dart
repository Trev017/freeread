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
  String selectedValue = "Default";
  //String alphaDesc = "Alphabetically (Descending)";
  //String alphaAsc = "Alphabetically (Ascending)";
  List<DropdownMenuItem<String>> get options {
    List<DropdownMenuItem<String>> dropdownList = [
      DropdownMenuItem(child: Text("Default"), value: "Default"),
      DropdownMenuItem(child: Text("Alphabetically (Descending)"), value: "Alphabetically (Descending)"),
      DropdownMenuItem(child: Text("Alphabetically (Ascending)"), value: "Alphabetically (Ascending)"),
    ];
    return dropdownList;
  }
  late Future<List<dynamic>> requestedList;

  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  Future<List<dynamic>> getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

  @override
  void initState() {
    requestedList = getRequest();
    //originalList();
    super.initState();
  }

  Future<void> originalList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      requestedList = getRequest();
    });
  }

  //Sorts the list in descending order
  Future<List<dynamic>> sortAlphaDesc() async {
    List<dynamic> rl = await requestedList;
    //Map mrl = rl.asMap();
    Map mrl = Map.fromIterable(rl, key: (item) => rl.indexOf(item));
    List<dynamic> listToSort = mrl.entries.toList()..sort((a, b) {
      //MapEntry<int, dynamic> entryA = a as MapEntry<int, dynamic>;
      //MapEntry<int, dynamic> entryB = b as MapEntry<int, dynamic>;
      return b.value["title"].compareTo(a.value["title"]);
      //return a.value.compareTo(b.value);
    });
    return listToSort;
    /*
    listToSort.sort((a, b) {
      return a['books']['title'].toLowerCase().compareTo(b['books']['title'].toLowerCase());
    });
    return listToSort;
    */
    /*
    setState(() {
      requestedList = listToSort;
    });
    */
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
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Sort by"),
                      content: DropdownButtonFormField(
                        value: selectedValue,
                        items: options,
                        onChanged: (String? value) {
                          //selectedValue = value!.toString();
                          setState(() {
                            selectedValue = value!.toString();
                            /*
                            String selectedValue = "Default";
                            String alphaDesc = "Alphabetically (Descending)";
                            String alphaAsc = "Alphabetically (Ascending)";
                            */
                            switch (value) {
                              case "Default":
                                originalList();
                                break;
                              case "Alphabetically (Descending)":
                                setState(() {
                                  requestedList = sortAlphaDesc();
                                });
                                break;
                              case "Alphabetically (Ascending)":
                                //
                                break;
                              default:
                                break;
                            }
                          });
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Continue');
                          },
                          child: const Text("Continue"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Sort",),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          //Vertical list builder
          child: FutureBuilder(
              future: requestedList,
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
                                        bookRss: snapshot.data[index]['url_rss'],
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