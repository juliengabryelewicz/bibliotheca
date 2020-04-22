import 'package:flutter/material.dart';

class Empty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Aucun livre",
        textScaleFactor: 2.5,
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Colors.green,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }

}