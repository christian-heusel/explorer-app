import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClosedTaskPage extends StatefulWidget {
  ClosedTaskPage({Key key}) : super(key: key);

  @override
  ClosedTaskPageState createState() => ClosedTaskPageState();
}

class ClosedTaskPageState extends State<ClosedTaskPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('In Liste alle bearbeiteten Tasks anzeigen')));
  }
}
