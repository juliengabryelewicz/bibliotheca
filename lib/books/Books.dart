import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "BooksDb.dart";
import "BooksList.dart";
import "BooksEntry.dart";
import "BooksModel.dart" show BooksModel, booksModel;

class Books extends StatelessWidget {


  Books() {

    booksModel.loadData("books", BooksDb.db);

  } /* End constructor. */

  Widget build(BuildContext inContext) {

    return ScopedModel<BooksModel>(
      model : booksModel,
      child : ScopedModelDescendant<BooksModel>(
        builder : (BuildContext inContext, Widget inChild, BooksModel inModel) {
          return IndexedStack(
            index : inModel.stackIndex,
            children : [
              BooksList(),
              BooksEntry()
            ] /* End IndexedStack children. */
          ); /* End IndexedStack. */
        } /* End ScopedModelDescendant builder(). */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */


} /* End class. */
