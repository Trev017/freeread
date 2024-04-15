import 'BookModelClass.dart';
import 'package:hive/hive.dart';

class BookModelMethods {
  String hiveBox = 'hive_local_db';

  void addBook(BookModel bookModel) async {
    var box = await Hive.openBox(hiveBox);
    var mapBookData = bookModel.toMap(bookModel);
    await box.add(mapBookData);
    Hive.close();
  }

  Future<List<BookModel>> getBookList() async {
    var box = await Hive.openBox(hiveBox);
    List<BookModel> books = [];
    for (int i = box.length - 1; i >= 0; i--) {
      var bookMap = box.getAt(i);
      books.add(BookModel.fromMap(Map.from(bookMap)));
    }
    return books;
  }

  Future<bool> containsBooks() async {
    var box = await Hive.openBox(hiveBox);
    if (box.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAll() async {
    var box = await Hive.openBox(hiveBox);
    await box.clear();
  }
}