import 'dart:io';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import 'package:path_provider/path_provider.dart';
import "BooksModel.dart";

class BooksDb {

  BooksDb._();
  static final BooksDb db = BooksDb._();

  Database _db;

  Future get database async {

    if (_db == null) {
      _db = await init();
    }

    return _db;

  } /* End database getter. */

  Future<Database> init() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, "books.db");
    Database db = await openDatabase(path, version : 1, onOpen : (db) { },
      onCreate : (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS books ("
            "id INTEGER PRIMARY KEY,"
            "name TEXT,"
            "year TEXT,"
            "author TEXT,"
            "description TEXT"
          ")"
        );
      }
    );
    return db;

  } /* End init(). */


  Book bookFromMap(Map inMap) {

    Book book = Book();
    book.id = inMap["id"];
    book.name = inMap["name"];
    book.year = inMap["year"];
    book.author = inMap["author"];
    book.description = inMap["description"];

    return book;

  } /* End bookFromMap(); */

  Map<String, dynamic> bookToMap(Book inBook) {

    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inBook.id;
    map["name"] = inBook.name;
    map["year"] = inBook.year;
    map["author"] = inBook.author;
    map["description"] = inBook.description;

    return map;

  } /* End bookToMap(). */

  Future create(Book inBook) async {

    Database db = await database;

    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM books");
    int id = val.first["id"];
    if (id == null) { id = 1; }

    await db.rawInsert(
      "INSERT INTO books (id, name, year, author, description) VALUES (?, ?, ?, ?, ?)",
      [
        id,
        inBook.name,
        inBook.year,
        inBook.author,
        inBook.description
      ]
    );

    return id;

  } /* End create(). */

  Future<Book> get(int inID) async {

    Database db = await database;
    var rec = await db.query("books", where : "id = ?", whereArgs : [ inID ]);

    return bookFromMap(rec.first);

  } /* End get(). */

  Future<List> getAll() async {

    Database db = await database;
    var recs = await db.query("books");
    var list = recs.isNotEmpty ? recs.map((m) => bookFromMap(m)).toList() : [ ];

    return list;

  } /* End getAll(). */

  Future update(Book inBook) async {

    Database db = await database;
    return await db.update("books", bookToMap(inBook), where : "id = ?", whereArgs : [ inBook.id ]);

  } /* End update(). */


  Future delete(int inID) async {

    Database db = await database;
    return await db.delete("books", where : "id = ?", whereArgs : [ inID ]);

  } /* End delete(). */


} /* End class. */