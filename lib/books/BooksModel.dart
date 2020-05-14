import "../BaseModel.dart";

class Book {

  int id;
  String name;
  String author;
  String description;
  String year; // YYYY


}

class BooksModel extends BaseModel {

  void triggerRebuild() {

    notifyListeners();

  } /* End triggerRebuild(). */


} /* End class. */

BooksModel booksModel = BooksModel();
