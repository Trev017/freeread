import 'package:hive/hive.dart';

part 'BookModelClass.g.dart';

//Model class used for converting API data to audiobooks to store in a Hive box.
@HiveType(typeId: 0)
class BookModel {

  //Class variables
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late String language;
  @HiveField(4)
  late String copyright_year;
  @HiveField(5)
  late String url_rss;
  @HiveField(6)
  late num totaltimesecs;
  @HiveField(7)
  late List author;
  @HiveField(8)
  late List chapters;

  //Class constructor
  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.copyright_year,
    required this.url_rss,
    required this.totaltimesecs,
    required this.author,
    required this.chapters,
  });

  //Converts an audiobook model in Hive to a Map.
  Map<String, dynamic> toMap(BookModel bm) {
    Map<String, dynamic> bookModelClassMap = Map();
    bookModelClassMap["id"] = bm.id;
    bookModelClassMap["title"] = bm.title;
    bookModelClassMap["description"] = bm.description;
    bookModelClassMap["language"] = bm.language;
    bookModelClassMap["copyright_year"] = bm.copyright_year;
    bookModelClassMap["url_rss"] = bm.url_rss;
    bookModelClassMap["totaltimesecs"] = bm.totaltimesecs;
    bookModelClassMap["author"] = bm.author;
    bookModelClassMap["chapters"] = bm.chapters;
    return bookModelClassMap;
  }

  //Converts a Map to an audiobook model in Hive.
  factory BookModel.fromMap(Map<String, dynamic> bookMapJson) {
    return BookModel(
        id: bookMapJson['id'],
        title: bookMapJson['title'],
        description: bookMapJson['description'],
        language: bookMapJson['language'],
        copyright_year: bookMapJson['copyright_year'],
        url_rss: bookMapJson['url_rss'],
        totaltimesecs: bookMapJson['totaltimesecs'],
        author: bookMapJson['author'],
        chapters: bookMapJson['chapters']
    );
  }
}