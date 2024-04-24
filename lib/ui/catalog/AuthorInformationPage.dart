import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';
//Class to display the list of books of a specific author.
class AuthorInformationPage extends StatefulWidget {

  //Class variables
  final String authorFirst;
  final String authorLast;

  //Class constructor
  const AuthorInformationPage(
      {
        super.key,
        required this.authorFirst,
        required this.authorLast,
      }
      );

  @override
  State<AuthorInformationPage> createState() => _MyAuthorInformationPageState();
}

class _MyAuthorInformationPageState extends State<AuthorInformationPage> {
  String selectedValue = "Default";

  //List to contain the sort options.
  List<DropdownMenuItem<String>> get options {
    List<DropdownMenuItem<String>> dropdownList = [
      const DropdownMenuItem(value: "Default", child: Text("Default")),
      const DropdownMenuItem(value: "Alphabetically (Ascending)", child: Text("Alphabetically (Ascending)")),
      const DropdownMenuItem(value: "Alphabetically (Descending)", child: Text("Alphabetically (Descending)")),
    ];
    return dropdownList;
  }
  late Future<List<dynamic>> requestedList = Future.value([]);

  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  //Gets the list of books using the API.
  Future<List<dynamic>> getRequest() async {
    String s = onlineService.booksUrl;
    final rp = await dio.get("$s&author=${widget.authorFirst}&author=${widget.authorLast}");
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }

  @override
  void initState() {
    requestedList = getRequest();
    //originalList();
    super.initState();
  }

  //Gets the original list obtained from the GET request.
  Future<void> originalList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      requestedList = getRequest();
    });
  }

  //Sorts the list in descending order.
  Future<List<dynamic>> sortAlphaDesc() async {
    List<dynamic> rl = await requestedList;
    Map mrl = Map.fromIterable(rl, key: (item) => rl.indexOf(item));
    List<dynamic> listToSort = mrl.entries.toList()..sort(
            (a, b) {
          return b.value["title"].compareTo(a.value["title"]);
        });
    return listToSort;
  }

  //Sorts the list in ascending order.
  Future<List<dynamic>> sortAlphaAsc() async {
    List<dynamic> rl = await requestedList;
    Map mrl = Map.fromIterable(rl, key: (item) => rl.indexOf(item));
    List<dynamic> listToSort = mrl.entries.toList()..sort(
            (a, b) {
          return a.value["title"].compareTo(b.value["title"]);
        });
    return listToSort;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        appBar: AppBar(
          title: Text("Browse Books by ${widget.authorFirst} ${widget.authorLast}", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: const BackButton(),
              onTap: () {
                Navigator.pop(context);
              }
          ),
          actions: [
            //Alert dialog to display the sorting options.
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
                          setState(() {
                            selectedValue = value!.toString();
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
                                setState(() {
                                  requestedList = sortAlphaAsc();
                                });
                                break;
                              default:
                                originalList();
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
                  //Displays an error to indicate that the API is currently not available.
                  return Container(
                    child: const Center(
                      child: Text("Database currently not available"),
                    ),
                  );
                } else if (snapshot.hasError && snapshot.error is SocketException) {
                  //Displays an error to indicate that the user is currently disconnected from the Internet.
                  return Container(
                    child: const Center(
                      child: Text("Please connect to the Internet"),
                    ),
                  );
                } else {
                  //Displays a list of books.
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) => Card(
                      child: SizedBox.square(
                        dimension: 45,
                        child: ListTile(
                          //Redirects the user to the book information page.
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
                            child: Text(snapshot.data![index]['title']),
                          ),
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