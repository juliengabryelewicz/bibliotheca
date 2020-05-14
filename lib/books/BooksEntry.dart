import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "BooksDb.dart";
import "BooksModel.dart" show BooksModel, booksModel;

class BooksEntry extends StatelessWidget {

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _yearEditingController = TextEditingController();
  final TextEditingController _authorEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BooksEntry() {

    _nameEditingController.addListener(() {
      booksModel.entityBeingEdited.name = _nameEditingController.text;
    });
    _authorEditingController.addListener(() {
      booksModel.entityBeingEdited.author = _authorEditingController.text;
    });
    _yearEditingController.addListener(() {
      booksModel.entityBeingEdited.year = _yearEditingController.text;
    });
    _descriptionEditingController.addListener(() {
      booksModel.entityBeingEdited.description = _descriptionEditingController.text;
    });

  }

  Widget build(BuildContext inContext) {

    if (booksModel.entityBeingEdited != null) {
      _nameEditingController.text = booksModel.entityBeingEdited.name;
      _authorEditingController.text = booksModel.entityBeingEdited.author;
      _yearEditingController.text = booksModel.entityBeingEdited.year;
      _descriptionEditingController.text = booksModel.entityBeingEdited.description;
    }

    return ScopedModel(
      model : booksModel,
      child : ScopedModelDescendant<BooksModel>(
        builder : (BuildContext inContext, Widget inChild, BooksModel inModel) {
          return Scaffold(
            bottomNavigationBar : Padding(
            padding : EdgeInsets.symmetric(vertical : 0, horizontal : 10),
            child : Row(
              children : [
                FlatButton(
                  child : Text("Annuler"),
                  onPressed : () {
                    // Hide soft keyboard.
                    FocusScope.of(inContext).requestFocus(FocusNode());
                    // Go back to the list view.
                    inModel.setStackIndex(0);
                  }
                ),
                Spacer(),
                FlatButton(
                  child : Text("Sauvegarder"),
                  onPressed : () { _save(inContext, inModel); }
                )
              ]
            )),
            body : Form(
              key : _formKey,
              child : ListView(
                children : [
                  ListTile(
                    leading : Icon(Icons.book),
                    title : TextFormField(
                      decoration : InputDecoration(hintText : "Nom"),
                      controller : _nameEditingController,
                      validator : (String inValue) {
                        if (inValue.length == 0) { return "Veuillez entrer un nom"; }
                        return null;
                      }
                    )
                  ),
                  ListTile(
                    leading : Icon(Icons.person),
                    title : TextFormField(
                      decoration : InputDecoration(hintText : "Auteur"),
                      controller : _authorEditingController,
                      validator : (String inValue) {
                        if (inValue.length == 0) { return "Veuillez entrer un auteur"; }
                        return null;
                      }
                    )
                  ),
                  // Phone.
                  ListTile(
                      leading : Icon(Icons.today),
                      title : TextFormField(
                          keyboardType : TextInputType.number,
                          decoration : InputDecoration(hintText : "Année de parution"),
                          controller : _yearEditingController
                      )
                  ),
                  // Description
                  ListTile(
                    title : TextFormField(
                      decoration : InputDecoration(hintText : "Description"),
                      controller : _descriptionEditingController
                    )
                  ),
                ] /* End Column children. */
              ) /* End ListView. */
            ) /* End Form. */
          ); /* End Scaffold. */
        } /* End ScopedModelDescendant builder(). */
      ) /* End ScopedModelDescendant. */
    ); /* End ScopedModel. */

  } /* End build(). */

  void _save(BuildContext inContext, BooksModel inModel) async {

    if (!_formKey.currentState.validate()) { return; }

    var id;

    if (inModel.entityBeingEdited.id == null) {

      id = await BooksDb.db.create(booksModel.entityBeingEdited);

    } else {

      id = booksModel.entityBeingEdited.id;
      await BooksDb.db.update(booksModel.entityBeingEdited);

    }

    booksModel.loadData("books", BooksDb.db);

    inModel.setStackIndex(0);

    Scaffold.of(inContext).showSnackBar(
      SnackBar(
        backgroundColor : Colors.green,
        duration : Duration(seconds : 2),
        content : Text("Livre sauvegardé")
      )
    );

  } /* End _save(). */


} /* End class. */
