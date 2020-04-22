import 'package:flutter/material.dart';
import 'package:bibliotheca/model/book.dart';
import 'package:bibliotheca/widgets/texte_bibliotheca.dart';

class BookDetail extends StatefulWidget {
  Book book;

  BookDetail(Book book) {
    this.book = book;
  }

  @override
  _BookDetailState createState() => new _BookDetailState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class _BookDetailState extends State<BookDetail> {

  /*@override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Détail du livre"),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              new TexteBibliotheca(widget.book.name, fontSize: 25.0, fontStyle: FontStyle.italic,),
              padding(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new TexteBibliotheca(widget.book.author),
                  new TexteBibliotheca(widget.book.year.toString(), color: Colors.green,),
                ],
              ),
              padding(),
              new TexteBibliotheca(widget.book.description),
              padding(),
            ],
          ),
        ),
    );
  }

  Padding padding() {
    return new Padding(padding: EdgeInsets.only(top: 20.0));
  }

}