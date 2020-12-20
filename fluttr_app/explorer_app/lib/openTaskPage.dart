import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenTaskPage extends StatefulWidget
{
  OpenTaskPage({Key key}) : super(key: key);

  @override
  OpenTaskPageState createState() => OpenTaskPageState();
}

class OpenTaskPageState extends State<OpenTaskPage>
{
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center (
          child:
          Text('In Liste alle Offenen tasks anzeigen')
        )
    );
  }
}