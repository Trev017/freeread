import 'package:hive/hive.dart';

part 'BookModelClass.g.dart';

@HiveType(typeId: 0)
class BookModel {

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

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.copyright_year,
    required this.url_rss,
    //required this.url_zip_file,
    required this.totaltimesecs,
    required this.author,
    required this.chapters,
  });

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