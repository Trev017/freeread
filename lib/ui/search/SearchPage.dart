import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/OnlineService.dart';
import '../BookInformationPage.dart';
//Class to display the search page.
class SearchPage extends StatefulWidget {

  //Class constructor
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MySearchPage();
}

class _MySearchPage extends State<SearchPage> {
  TextEditingController filter = TextEditingController();
  Dio dio = Dio();
  OnlineService onlineService = OnlineService();
  String searchText = "";
  String selectedSortValue = "Default";
  //List to contain the sort options.
  List<DropdownMenuItem<String>> get sortOptions {
    List<DropdownMenuItem<String>> dropdownList = [
      const DropdownMenuItem(value: "Default", child: Text("Default")),
      const DropdownMenuItem(value: "Alphabetically (Ascending)", child: Text("Alphabetically (Ascending)")),
      const DropdownMenuItem(value: "Alphabetically (Descending)", child: Text("Alphabetically (Descending)")),
    ];
    return dropdownList;
  }
  String selectedSearchValue = "Title";
  //List to contain the search options.
  List<DropdownMenuItem<String>> get searchOptions {
    List<DropdownMenuItem<String>> dropdownList = [
      const DropdownMenuItem(value: "Title", child: Text("Title")),
      const DropdownMenuItem(value: "Authors", child: Text("Authors")),
    ];
    return dropdownList;
  }


  //Method to perform a GET request to initially build a list.
  Future getBooksRequest() async {
    final rp = await dio.get(onlineService.booksUrl);
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }
  //Method to perform a GET request of books with a specified query.
  Future getBooksbyTitleRequest(String q) async {
    String s = onlineService.booksUrl;
    final rp = await dio.get("$s&title=^$q");
    List<Map<String, dynamic>> books = (rp.data['books'] as List).map((e) => e as Map<String, dynamic>).toList();
    return books;
  }
  //Method to perform a GET request of authors with a specified query.
  Future getAuthorsRequest(String q) async {
    String s = onlineService.authorsUrl;
    final rp = await dio.get("$s&last_name=$q");
    List<Map<String, dynamic>> authors = (rp.data['authors'] as List).map((e) => e as Map<String, dynamic>).toList();
    return authors;
  }
  late Future<dynamic> requestedList = Future.value([]);

  pageState() {
    filter.addListener(() {
      if (filter.text.isEmpty) {
        setState(() {
          searchText = "";
        });
      } else {
        setState(() {
          searchText = filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    requestedList = getBooksRequest();
    super.initState();
  }

  Future originalList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      requestedList = getBooksRequest();
    }
    );
  }

  //Sorts the list in descending order.
  Future<List<dynamic>> sortAlphaDesc() async {
    List<dynamic> rl = await requestedList;
    //Map mrl = rl.asMap();
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

  //Gets the search results on both books and authors.
  Future queryResults() async {
    return Future.wait([getBooksbyTitleRequest(searchText), getAuthorsRequest(searchText)]);
  }

  @override
  Widget build(BuildContext context) {
    //Navigator and MaterialPageRoute ensures that the NavBar persists
    return Navigator(
        onGenerateRoute: (RouteSettings rs) {
          return MaterialPageRoute(
            settings: rs,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Search Page", textAlign: TextAlign.center,),
                  leading: const Icon(Icons.search),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (v) {
                          setState(() {
                            searchText = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.search),
                              Tooltip(
                                message: "Filter Search",
                                child: IconButton(
                                  //Alert dialog to display the filtering and sorting options.
                                  icon: const Icon(Icons.filter_list),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Search Settings"),
                                          content: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text("Search Works By:"),
                                              DropdownButtonFormField(
                                                value: selectedSearchValue,
                                                items: searchOptions,
                                                onChanged: (Object? value) {
                                                  setState(() {
                                                    selectedSearchValue = value!.toString();
                                                    switch (value) {
                                                      case "Title":
                                                      //
                                                        break;
                                                      case "Authors":
                                                        setState(() {
                                                          //
                                                        });
                                                        break;
                                                      default:
                                                        break;
                                                    }
                                                  });
                                                },
                                              ),
                                              const Text("Sort by:"),
                                              DropdownButtonFormField(
                                                value: selectedSortValue,
                                                items: sortOptions,
                                                onChanged: (Object? value) {
                                                  setState(() {
                                                    selectedSortValue = value!.toString();
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
                                            ],
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: FutureBuilder(
                        future: getBooksbyTitleRequest(searchText),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Center(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (ctx, index) {
                                    if (snapshot.data[index]['title']
                                        .contains(searchText)) {
                                      //Displays a list of books based on search results.
                                      return ListTile(
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
                                            minimumSize: const Size.fromHeight(50),
                                          ),
                                          child: Text(snapshot.data[index]['title']),
                                        ),
                                      );
                                    }
                                    return null;
                                  }),
                            );
                            //Displays an error to indicate that the search result is incorrect.
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text("No results"));
                            //Displays an error to indicate that the user is currently disconnected from the Internet.
                          } else if (snapshot.data == null) {
                            return const Center(child: Text("Database currently not available"));
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
                //resizeToAvoidBottomInset: false,
              );
            }
          );
        }
    );
  }
}
