import 'package:flutter/material.dart';

class TexteBibliotheca extends Text {

  TexteBibliotheca(String data, {textAlign: TextAlign.center, color: Colors.green, fontSize: 15.0, fontStyle: FontStyle.normal}):
      super(
        data,
        textAlign: textAlign,
        style: new TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: fontStyle
        )
      );

}