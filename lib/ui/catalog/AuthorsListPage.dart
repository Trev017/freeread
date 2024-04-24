import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import 'AuthorInformationPage.dart';
//Class to display the list of authors.
class AuthorsListPage extends StatefulWidget {

  //Class constructor
  const AuthorsListPage({super.key});

  @override
  State<AuthorsListPage> createState() => _MyAuthorsListPage();
}

class _MyAuthorsListPage extends State<AuthorsListPage> {
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
  late Future<dynamic> requestedList = Future.value([]);

  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  //Gets the list of books using the API.
  Future<List<dynamic>> getRequest() async {
    final rp = await dio.get(onlineService.authorsUrl);
    List<Map<String, dynamic>> authors = (rp.data['authors'] as List).map((e) => e as Map<String, dynamic>).toList();
    return authors;
  }

  @override
  void initState() {
    requestedList = getRequest();
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
    //Map mrl = rl.asMap();
    Map mrl = Map.fromIterable(rl, key: (item) => rl.indexOf(item));
    List<dynamic> listToSort = mrl.entries.toList()..sort(
            (a, b) {
              return b.value["last_name"].compareTo(a.value["last_name"]);
            });
    return listToSort;
  }

  //Sorts the list in ascending order.
  Future<List<dynamic>> sortAlphaAsc() async {
    List<dynamic> rl = await requestedList;
    //Map mrl = rl.asMap();
    Map mrl = Map.fromIterable(rl, key: (item) => rl.indexOf(item));
    List<dynamic> listToSort = mrl.entries.toList()..sort(
            (a, b) {
          return a.value["last_name"].compareTo(b.value["last_name"]);
        });
    return listToSort;
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
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    //Displays an error to indicate that the API is currently not available.
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
                  //Displays a list of authors.
                  int il = snapshot.data.length;
                  //il = 6426;
                  return ListView.builder(
                    itemCount: il,
                    itemBuilder: (ctx, index) {
                      Card(
                        child: SizedBox.square(
                          dimension: 45,
                          child: ListTile(
                            //Redirects the user to the author information page.
                            title: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthorInformationPage(
                                            authorFirst: snapshot.data[index]['first_name'],
                                            authorLast: snapshot.data[index]['last_name']
                                        )
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: Text('${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}