import 'package:json_annotation/json_annotation.dart';

part 'BookModel.g.dart';

@JsonSerializable()
class BookModel {

  @JsonKey(name : "id")
  late String id;
  @JsonKey(name : "title")
  late String title;
  @JsonKey(name : "description")
  late String description;
  @JsonKey(name : "language")
  late String language;
  @JsonKey(name : "copyright_year")
  late String copyright_year;
  @JsonKey(name : "url_rss")
  late String url_rss;
  @JsonKey(name : "url_zip_file")
  late String url_zip_file;
  @JsonKey(name : "totaltimesecs")
  late num totaltimesecs;

  BookModel({
    required this.id, required this.title, required this.description,
    required this.language, required this.copyright_year, required this.url_rss,
    required this.url_zip_file, required this.totaltimesecs
  });
  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  factory BookModel.fromMap(Map<String, dynamic> bookMap) {
    return BookModel(
      id: bookMap['id'],
      title: bookMap['title'],
      description: bookMap['description'],
      language: bookMap['language'],
      copyright_year: bookMap['copyright_year'],
      url_rss: bookMap['url_rss'],
      url_zip_file: bookMap['url_zip_file'],
      totaltimesecs: bookMap['totaltimesecs'],
    );
  }
  /*
  static List<BookModel> fromJsonArray(List l) {
    List<BookModel> bookList = <BookModel>[];
    for (var b in l) {
      bookList.add(BookModel.fromJson(b));
    }
    return bookList;
  }
  */
  /*
  factory BookModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookModel(
        id: parsedJson['id'] as String,
        title: parsedJson['title'] as String,
        description: parsedJson['description'] as String,
        language: parsedJson['language'] as String,
        copyright_year: parsedJson['copyright_year'] as String,
        url_rss: parsedJson['url_rss'] as String,
        url_zip_file: parsedJson['url_zip_file'] as String,
        totaltimesecs: parsedJson['totaltimesecs'] as num
    );
  }
  */
}

class BookModelList {
  late final List<BookModel> books;
  BookModelList({required this.books});
  factory BookModelList.fromJson(List<dynamic> parsedJson) {
    List<BookModel> bookList = List<BookModel>.empty(growable: true);
    bookList = parsedJson.map((e) => BookModel.fromJson(e)).toList();
    return new BookModelList(
        books: bookList
    );
  }
}