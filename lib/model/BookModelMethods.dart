import 'BookModelClass.dart';
import 'package:hive/hive.dart';

//Class containing methods to perform Hive functions.
class BookModelMethods {
  String hiveBox = 'hive_local_db';

  //Adds an audiobook to the Hive box.
  void addBook(BookModel bookModel) async {
    var box = await Hive.openBox(hiveBox);
    var mapBookData = bookModel.toMap(bookModel);
    await box.add(mapBookData);
    Hive.close();
  }

  //Gets a list of audiobooks from the Hive box.
  Future<List<BookModel>> getBookList() async {
    var box = await Hive.openBox(hiveBox);
    List<BookModel> books = [];
    for (int i = box.length - 1; i >= 0; i--) {
      var bookMap = box.getAt(i);
      books.add(BookModel.fromMap(Map.from(bookMap)));
    }
    return books;
  }

  //Checks if the Hive box contains data.
  Future<bool> containsBooks() async {
    var box = await Hive.openBox(hiveBox);
    if (box.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Removes all audiobooks in the Hive box.
  void deleteAll() async {
    var box = await Hive.openBox(hiveBox);
    await box.clear();
  }
}