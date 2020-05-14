import "package:scoped_model/scoped_model.dart";

class BaseModel extends Model {

  int stackIndex = 0;
  List entityList = [ ];
  var entityBeingEdited;

  void loadData(String inEntityType, dynamic inDatabase) async {

    entityList = await inDatabase.getAll();
    notifyListeners();

  } /* End loadData(). */

  void setStackIndex(int inStackIndex) {

    stackIndex = inStackIndex;
    notifyListeners();

  } /* End setStackIndex(). */


} /* End class. */
