import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../services/OnlineService.dart';

class BookInformationPage extends StatefulWidget {
  final String bookId;
  final String bookTitle;
  final String bookDescription;
  final int bookTotalTime;
  final List bookAuthor;
  final List bookChapters;

  const BookInformationPage(
      {
        super.key,
        required this.bookId,
        required this.bookTitle,
        required this.bookDescription,
        required this.bookTotalTime,
        required this.bookAuthor,
        required this.bookChapters,
      }
      );

  @override
  State<BookInformationPage> createState() => _MyBookInformationPagePage();
}

class _MyBookInformationPagePage extends State<BookInformationPage> {
  int currentPageIndex = 0;

  String convertTotalSeconds(int x) {
    //String parsedTotalSeconds = int.parse(x);
    final convertTotalSeconds = Duration(seconds: x);
    return convertTotalSeconds.toString();
  }

  String getFirstName() {
    return widget.bookAuthor[0]['first_name'];
  }

  String getLastName() {
    return widget.bookAuthor[0]['last_name'];
  }

  @override
  void initState() {
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    List widgetList = [
      //Description
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Text(
              widget.bookDescription,
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
          ),
        ),
      ),
      //Chapters
      Expanded(
        flex: 1,
        child: Wrap(
          //direction: Axis.vertical,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.bookChapters.length,
                itemBuilder: (ctx, index) {
                  String apiChapterSeconds = widget.bookChapters[index]['playtime'];
                  int parsedChapterSeconds = int.parse(apiChapterSeconds);
                  final convertChapterSeconds = Duration(seconds: parsedChapterSeconds);
                  return ListTile(
                    title: Text(widget.bookChapters[index]['title']),
                    subtitle: Text('Time to complete: ${convertChapterSeconds.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              //
                            }
                        ),
                        Tooltip(
                          message: "Download chapter",
                          child: IconButton(
                            icon: Icon(Icons.file_download_outlined),
                            onPressed: () {
                              //
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    ];
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: BackButton(),
                onTap: () {
                  Navigator.pop(context);
                }),
            actions: [
              Tooltip(
                message: "Download all",
                child: IconButton(
                  icon: Icon(Icons.file_download_outlined),
                  onPressed: () {
                    //
                  },
                ),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          //Book Cover
                          Expanded(
                            //flex: 3,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Text(widget.bookTitle),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          //Title
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Center(
                                child: Text(widget.bookTitle),
                              ),
                            ),
                          ),
                          //Author
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Center(
                                child: Text("By: ${getFirstName()} ${getLastName()}"),
                              ),
                            ),
                          ),
                          //Total Time
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Center(
                                child: Text('Total reading time: ${convertTotalSeconds(widget.bookTotalTime)}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          //Play
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            padding: EdgeInsets.all(5),
                            child: OutlinedButton(
                              onPressed: () {
                                //
                              },
                              style: OutlinedButton.styleFrom(
                                shape: ContinuousRectangleBorder(),
                                //backgroundColor: Colors.grey.shade50,
                                //minimumSize: Size.fromHeight(90),
                              ),
                              child: const Text ("Start Listening"),
                            ),
                          ),
                          const Spacer(),
                          //Like
                          Container(
                            /*
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            */
                            padding: EdgeInsets.all(25),
                            child: Tooltip(
                              message: "Mark as favorite",
                              child: IconButton(
                                icon: Icon(Icons.star_border_sharp),
                                selectedIcon: Icon(Icons.star_sharp),
                                onPressed: () {
                                  setState(() {
                                    //
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //const Spacer(),
              //ButtonBar
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Row(
                    children: [
                      /*
                      Center(
                        child: Column(
                          children: [
                            //ButtonBar
                            Container(
                              //padding: const EdgeInsets.all(5),
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: CupertinoSegmentedControl(
                                onValueChanged: (int i) {
                                  setState(() {
                                    currentPageIndex = i;
                                  });
                                },
                                selectedColor: Colors.brown,
                                children: const <int, Widget> {
                                  0: Text("Description"),
                                  1: Text("Chapters"),
                                },
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: widgetList[currentPageIndex],
                              ),
                            ),
                          ],
                        ),
                      ),
                      */
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            //ButtonBar
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: CupertinoSegmentedControl(
                                  onValueChanged: (int i) {
                                    setState(() {
                                      currentPageIndex = i;
                                    });
                                  },
                                  selectedColor: Colors.brown,
                                  children: const <int, Widget> {
                                    0: Text("Description"),
                                    1: Text("Chapters"),
                                  },
                                ),
                              ),
                            ),
                            Center(
                              /*
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: widgetList[currentPageIndex],
                                ),
                              ),
                              */
                              //
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: widgetList[currentPageIndex],
                              ),
                              //
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
