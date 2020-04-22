import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'book.dart';

class DatabaseBibliotheca {

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await create();
      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'bibliotheca.db');
    var bdd = await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE book (
     id INTEGER PRIMARY KEY,
     name TEXT NOT NULL,
     year INTEGER,
     author TEXT,
     description TEXT)
     '''
    );
  }
  Future<Book> updateInsertBook(Book book) async {
    Database myDatabase = await database;
    if (book.id == null) {
      book.id = await myDatabase.insert('book', book.toMap());
    } else {
      await myDatabase.update('book', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
    }
    return book;
  }

  Future<int> delete(int id) async {
    Database myDatabase = await database;
    return await myDatabase.delete('book', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> allBooks() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> resultats = await myDatabase.rawQuery('SELECT * FROM book ORDER BY name ASC');
    List<Book> books =[];
    resultats.forEach((resultat) {
      Book book = new Book();
      book.fromMap(resultat);
      books.add(book);
    });
    return books;
  }
}
