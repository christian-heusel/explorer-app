import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenTaskPage extends StatefulWidget {
  OpenTaskPage({Key key}) : super(key: key);

  @override
  OpenTaskPageState createState() => OpenTaskPageState();
}

class OpenTaskPageState extends State<OpenTaskPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      //Center(child: Text('In Liste alle Offenen tasks anzeigen'))),;
      body: new GridView.count(
        crossAxisCount: 3,
        children: new List<Widget>.generate(50, (index) {
          return /*new GridTile(
            child: new Card(
                child: new Center(
                  child: new Text('$index'),
                )),
          );*/
          new Container(
            padding: const EdgeInsets.all(8),
            child: Text('$index'),
          );
        }),
      ),
    );
  }
}
