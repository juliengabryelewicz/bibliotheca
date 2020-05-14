import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "BooksDb.dart";
import "BooksModel.dart" show Book, BooksModel, booksModel;

class BooksList extends StatelessWidget {

  Widget build(BuildContext inContext) {

    // Return widget.
    return ScopedModel<BooksModel>(
      model : booksModel,
      child : ScopedModelDescendant<BooksModel>(
        builder : (BuildContext inContext, Widget inChild, BooksModel inModel) {
          return Scaffold(
            floatingActionButton : FloatingActionButton(
              child : Icon(Icons.add, color : Colors.white),
              onPressed : () async {
                booksModel.entityBeingEdited = Book();
                booksModel.setStackIndex(1);
              }
            ),
            body : ListView.builder(
              itemCount : booksModel.entityList.length,
              itemBuilder : (BuildContext inBuildContext, int inIndex) {
                Book book = booksModel.entityList[inIndex];
                // Get reference to avatar file and see if it exists.
                return Column(
                  children : [
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio : .25,
                      child : ListTile(
                        leading : CircleAvatar(
                          backgroundColor : Colors.indigoAccent,
                          foregroundColor : Colors.white,
                        ),
                        title : Text("${book.name}"),
                        subtitle : book.name == null ? null : Text("${book.name}"),
                        onTap : () async {
                          booksModel.entityBeingEdited = await BooksDb.db.get(book.id);
                          booksModel.setStackIndex(1);
                        }
                      ),
                      secondaryActions : [
                        IconSlideAction(
                          caption : "Delete",
                          color : Colors.red,
                          icon : Icons.delete,
                          onTap : () => _deleteBook(inContext, book)
                        )
                      ]
                    ),
                    Divider()
                  ]
                ); /* End Column. */
              } /* End itemBuilder. */
            ) /* End ListView.builder. */
          ); /* End Scaffold. */
        } /* End ScopedModelDescendant builder. */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */

  Future _deleteBook(BuildContext inContext, Book inBook) async {

    return showDialog(
      context : inContext,
      barrierDismissible : false,
      builder : (BuildContext inAlertContext) {
        return AlertDialog(
          title : Text("Supprimer le livre"),
          content : Text("Etes-vous sûr de supprimer ${inBook.name}?"),
          actions : [
            FlatButton(child : Text("Annuler"),
              onPressed: () {
                Navigator.of(inAlertContext).pop();
              }
            ),
            FlatButton(child : Text("Supprimer"),
              onPressed : () async {
                await BooksDb.db.delete(inBook.id);
                Navigator.of(inAlertContext).pop();
                Scaffold.of(inContext).showSnackBar(
                  SnackBar(
                    backgroundColor : Colors.red,
                    duration : Duration(seconds : 2),
                    content : Text("Livre supprimé")
                  )
                );
                booksModel.loadData("books", BooksDb.db);
              }
            )
          ]
        );
      }
    );

  } /* End _deleteBook(). */


} /* End class. */
