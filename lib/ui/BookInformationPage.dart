import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//import 'package:webfeed/webfeed.dart';
import 'AudioProvider.dart';
import 'catalog/AuthorInformationPage.dart';
import '../model/BookModelClass.dart';
import '../model/BookModelMethods.dart';

class BookInformationPage extends StatefulWidget {
  final String bookId;
  final String bookTitle;
  final String bookDescription;
  final String bookLanguage;
  final String bookYear;
  final String bookRss;
  final int bookTotalTime;
  final List bookAuthor;
  final List bookChapters;

  const BookInformationPage(
      {
        super.key,
        required this.bookId,
        required this.bookTitle,
        required this.bookDescription,
        required this.bookLanguage,
        required this.bookYear,
        required this.bookRss,
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
  List convertChapterList = [];
  var audioprov;
  final BookModelMethods bookModelMethods = BookModelMethods();

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

  /*
  Future<String?> getRssImage() async {
    final client = http.Client();
    final response = await client.get(Uri.parse(widget.bookRss));
    final feed = RssFeed.parse(response.body);
    final imageUrl = feed.itunes?.image?.href;
    return imageUrl;
  }
  */

  /*
  Future<List> getAudioList() async {
    await Future.delayed(const Duration(seconds: 1));
    List? mp3List = [];
    final client = http.Client();
    final response = await client.get(Uri.parse(widget.bookRss));
    final feed = RssFeed.parse(response.body);
    final List? rssList = feed.items;
    for (int x = 0; x < rssList!.length; x++) {
      RssItem rssElement = rssList.elementAt(x);
      var contentElement = rssElement.media?.contents!.elementAt(0);
      String? mp3url = contentElement?.url;
      mp3List.add(mp3url);
    }
    return mp3List;
  }
  */
  /*
  List parseList() {
    List apiList = [];
    getAudioList().then((value) {
      for (var c in value) {
        apiList.add(c);
      }
        });
    return apiList;
  }
  */
  //

  void addtoFavorites(BookModel bookModel) {
    bookModelMethods.addBook(bookModel);
  }

  @override
  void initState() {
    /*
    getAudioList().then((value) {
      convertChapterList = value;
          return convertChapterList;
    });
    */
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

                  //Future<List> apiChapterList = getAudioList();
                  //apiChapterList.then((value) => null);
                  /*
                  Future<List> apiChapterList = getAudioList().then((value) {
                    if (value is List) {
                      convertChapterList = value;
                    }
                    return convertChapterList;
                    /*
                    return value.forEach((element) {
                      convertChapterList.add(element);
                      return convertChapterList;
                    });
                    */
                  });
                  */
                  /*
                  List convertChapterList = [];
                  List apiChapterList = getAudioList().then((dynamic value) {
                    List<dynamic> listData = value;
                    //
                  });
                  */
                  //List apiChapterList = parseList();
                  //apiChapterList.elementAt(index);
                  audioprov = Provider.of<AudioProvider>(context);
                  return ListTile(
                    title: Text(widget.bookChapters[index]['title']),
                    subtitle: Text('Time to complete: ${convertChapterSeconds.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              audioprov.setAudioBookAuthor(widget.bookTitle);
                              //context.read<AudioProvider>().setAudioBookAuthor(widget.bookTitle);
                              /*
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return AudioReader(audioBookTitle: widget.bookTitle);
                              }));
                              */
                            }
                        ),
                        Tooltip(
                          message: "Download chapter ${widget.bookChapters[index]['listen_url']}",
                          child: IconButton(
                            icon: const Icon(Icons.file_download_outlined),
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
            const Spacer(),
          ],
        ),
      ),
    ];
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: const BackButton(),
                onTap: () {
                  Navigator.pop(context);
                }),
            actions: [
              Tooltip(
                message: "Download all",
                child: IconButton(
                  icon: const Icon(Icons.file_download_outlined),
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
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AuthorInformationPage(
                                            authorFirst: getFirstName(),
                                            authorLast: getLastName(),
                                          )
                                      )
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  //backgroundColor: Colors.grey.shade50,
                                  //minimumSize: Size.fromHeight(90),
                                ),
                                child: Text ("By: ${getFirstName()} ${getLastName()}"),
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
                            padding: const EdgeInsets.all(5),
                            child: OutlinedButton(
                              onPressed: () {
                                //
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
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
                            padding: const EdgeInsets.all(25),
                            child: Tooltip(
                              message: "Mark as favorite",
                              child: IconButton(
                                icon: const Icon(Icons.star_border_sharp),
                                selectedIcon: const Icon(Icons.star_sharp),
                                onPressed: () {
                                  setState(() {
                                    BookModel addedFavorite = BookModel(
                                        id: widget.bookId,
                                        title: widget.bookTitle,
                                        description: widget.bookDescription,
                                        language: widget.bookLanguage,
                                        copyright_year: widget.bookYear,
                                        url_rss: widget.bookRss,
                                        totaltimesecs: widget.bookTotalTime,
                                        author: widget.bookAuthor,
                                        chapters: widget.bookChapters
                                    );
                                    addtoFavorites(addedFavorite);
                                    }
                                  );
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
                              child: SizedBox(
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
