import 'package:flutter/material.dart';
import 'package:bibliotheca/widgets/homepage_controller.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bibliotheca',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new HomepageController(title: 'Bibliotheca'),
    );
  }
}
