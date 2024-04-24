import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AudioProvider.dart';
import 'catalog/AuthorInformationPage.dart';
import '../model/BookModelClass.dart';
import '../model/BookModelMethods.dart';
//Class to display information of an audiobook.
class BookInformationPage extends StatefulWidget {

  //Class variables
  final String bookId;
  final String bookTitle;
  final String bookDescription;
  final String bookLanguage;
  final String bookYear;
  final String bookRss;
  final int bookTotalTime;
  final List bookAuthor;
  final List bookChapters;

  //Class constructor
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

  //Converts seconds to the hours, minutes, and seconds format.
  String convertTotalSeconds(int x) {
    final convertTotalSeconds = Duration(seconds: x);
    return convertTotalSeconds.toString();
  }

  //Gets the first name from the author variable.
  String getFirstName() {
    return widget.bookAuthor[0]['first_name'];
  }

  //Gets the last name from the author variable.
  String getLastName() {
    return widget.bookAuthor[0]['last_name'];
  }

  //Adds data about the book to the Hive box.
  void addtoFavorites(BookModel bookModel) {
    bookModelMethods.addBook(bookModel);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List widgetList = [
      //Summary description of the audiobook.
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
      //List of chapters of the audiobook.
      Expanded(
        flex: 1,
        child: Wrap(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.bookChapters.length,
                itemBuilder: (ctx, index) {
                  String apiChapterSeconds = widget.bookChapters[index]['playtime'];
                  int parsedChapterSeconds = int.parse(apiChapterSeconds);
                  final convertChapterSeconds = Duration(seconds: parsedChapterSeconds);
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
                            }
                        ),
                        Tooltip(
                          message: "Download chapter ${widget.bookChapters[index]['listen_url']}",
                          child: IconButton(
                            icon: const Icon(Icons.file_download_outlined),
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
                          //Container to display the audiobook title.
                          Expanded(
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
                          //Container to display the audiobook title.
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
                          //Container to display the author.
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: OutlinedButton(
                                //Redirects the user to the author information page.
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
                                ),
                                child: Text ("By: ${getFirstName()} ${getLastName()}"),
                              ),
                            ),
                          ),
                          //Container to display the total time.
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
                          //Button to start the audiobook from playing in the beginning.
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
                              ),
                              child: const Text ("Start Listening"),
                            ),
                          ),
                          const Spacer(),
                          //Button to mark the book as a favorite.
                          Container(
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
              //ButtonBar to select whether to view the description or the chapters.
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
