import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';
import '../../model/BookModelClass.dart';
import '../../model/BookModelMethods.dart';
//Class to display list of books stored offline.
class FavoritesPage extends StatefulWidget {

  //Class constructor
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<FavoritesPage> {
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
  final BookModelMethods bookModelMethods = BookModelMethods();
  List<BookModel> books = [];
  /*
  Future getRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }
  */

  //Gets all books in the Hive box.
  void getHiveBooks() async {
    var booksData = await bookModelMethods.getBookList();
    books.addAll(booksData);
  }

  @override
  void initState() {
    //getRequest();
    getHiveBooks();
    requestedList = bookModelMethods.getBookList();
    super.initState();
  }

  //Gets the original list obtained from the getter method.
  Future<void> originalList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      requestedList = bookModelMethods.getBookList();
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
          title: const Text("Favorites Page", textAlign: TextAlign.center,),
          leading: GestureDetector(
              child: const BackButton(),
              onTap: () {
                Navigator.pop(context);
              }
          ),
          actions: [
            //Alert dialog to display options to delete or sort.
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Edit Your Database"),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      //Deletes all audiobooks in Hive box.
                                      return AlertDialog(
                                        title: const Text("Delete All Entries"),
                                        content: const Text("This action is irreversible. Would you like to continue?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              bookModelMethods.deleteAll();
                                              Navigator.pop(context, 'Confirm');
                                            },
                                            child: const Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                        ],
                                        actionsAlignment: MainAxisAlignment.center,
                                      );
                                    }
                                );
                              },
                              child: const Text("Delete All Entries"),
                            ),
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
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Exit');
                              },
                              child: const Text("Exit"),
                            ),
                          ],
                        ),
                      ],
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                    );
                  },
                );
              },
              child: const Text("Edit",),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          //Vertical list builder
          child: FutureBuilder(
              future: bookModelMethods.getBookList(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false || bookModelMethods.containsBooks() == false || snapshot.data == null) {
                  //Displays an error to indicate that the box is empty.
                  return Container(
                    child: const Center(
                      child: Text("Database currently empty. Mark a book as your favorite."),
                    ),
                  );
                } else {
                  //Displays a list of books.
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: SizedBox.square(
                          dimension: 45,
                          child: ListTile(
                            //Redirects the user to the book information page.
                            title: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return BookInformationPage(
                                            bookId: snapshot.data[index].id,
                                            bookTitle: snapshot.data[index].title,
                                            bookDescription: snapshot.data[index].description,
                                            bookLanguage: snapshot.data[index].language,
                                            bookYear: snapshot.data[index].copyright_year,
                                            bookRss: snapshot.data[index].url_rss,
                                            bookTotalTime: snapshot.data[index].totaltimesecs,
                                            bookChapters: snapshot.data[index].chapters,
                                            bookAuthor: snapshot.data[index].author,
                                          );
                                        }
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                //backgroundColor: Colors.grey.shade50,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: Text(snapshot.data[index].title),
                            ),
                          ),
                        ),
                      );
                    },
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