import "dart:io";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "books/Books.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  /// The build() method.
  ///
  /// @param  inContext The BuildContext for this widget.
  /// @return           A Widget.
  Widget build(BuildContext inContext) {
    return MaterialApp(
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                    title: Text("Bibliotheca"),
                    bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.book), text: "Livres")
                        ] /* End TabBar.tabs. */
                    ) /* End TabBar. */
                ), /* End AppBar. */
                body: TabBarView(
                    children: [
                      Books()
                    ] /* End TabBarView.children. */
                ) /* End TabBarView. */
            ) /* End Scaffold. */
        ) /* End DefaultTabController. */
    ); /* End MaterialApp. */

  }

}
