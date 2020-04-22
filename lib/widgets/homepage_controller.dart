import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bibliotheca/model/book.dart';
import 'package:bibliotheca/widgets/empty.dart';
import 'package:bibliotheca/model/databaseBibliotheca.dart';
import 'bookDetail.dart';

class HomepageController extends StatefulWidget {
  HomepageController({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomepageControllerState createState() => new _HomepageControllerState();
}

class _HomepageControllerState extends State<HomepageController> {

  String bookName;
  String bookYear;
  String bookAuthor;
  String bookDescription;
  List<Book> books;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
          actions: <Widget>[
            new FlatButton(onPressed: (() =>ajouter(null)), child: new Text("Ajouter", style: new TextStyle(color: Colors.white),))
          ],
        ),
        body: (books == null || books.length == 0)
            ? new Empty()
            : new ListView.builder(
          itemCount: books.length,
            itemBuilder: (context, i) {
              Book book = books[i];
              return new ListTile(
                title: new Text(book.name),
                trailing: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: () {
                      DatabaseBibliotheca().delete(book.id).then((int) {
                        getBooks();
                      });
                    }),
                leading: new IconButton(icon: new Icon(Icons.edit), onPressed: (() => ajouter(book))),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                    return new BookDetail(book);
                  }));
                },
              );
            }
        )

    );
  }

  Future<Null> ajouter(Book book) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
            title: new Text('Ajouter un livre'),
            content: new Column(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: "Nom",
                    hintText: (book == null)? "Nom du livre": book.name,
                  ),
                  onChanged: (String str) {
                    bookName = str;
                  },
                )),
                new Expanded(
                    child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: "Année",
                    hintText: (book == null)? "Année du livre": book.year.toString(),
                  ),
                  onChanged: (String str) {
                    bookYear = str;
                  },
                )),
                new Expanded(
                    child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: "Auteur",
                    hintText: (book == null)? "Auteur(s) du livre": book.author,
                  ),
                  onChanged: (String str) {
                    bookAuthor = str;
                  },
                )),
                new Expanded(
                    child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: "Descirption",
                    hintText: (book == null)? "": book.description,
                  ),
                  onChanged: (String str) {
                    bookDescription = str;
                  },
                ))
              ],
            ),

            actions: <Widget>[
              new FlatButton(onPressed: (() => Navigator.pop(buildContext)), child: new Text('Annuler')),
              new FlatButton(onPressed: () {
                if (bookName != null) {
                  if (book == null) {
                    book = new Book();
                    Map<String, dynamic> map = {'name': bookName, 'author': bookAuthor, 'year': int.parse(bookYear), 'description': bookDescription};
                    book.fromMap(map);
                  } else {
                    book.name = bookName;
                    book.year = int.parse(bookYear);
                    book.author = bookAuthor;
                    book.description = bookDescription;
                  }
                  DatabaseBibliotheca().updateInsertBook(book).then((i) => getBooks());
                  bookName = null;
                  bookYear = null;
                  bookAuthor = null;
                  bookDescription = null;
                }
                Navigator.pop(buildContext);
              }, child: new Text('Valider', style: new TextStyle(color: Colors.blue),))
            ],
          );
        }
    );
  }

  void getBooks() {
    DatabaseBibliotheca().allBooks().then((books) {
      setState(() {
        this.books = books;
      });
    });
  }



}