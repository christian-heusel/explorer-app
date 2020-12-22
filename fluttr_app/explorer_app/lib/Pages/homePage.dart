import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget
{
  HomePage({Key key}) : super(key: key);


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
{
  Widget build(BuildContext context) {
    return Scaffold(
      body :new Container(
          padding: const EdgeInsets.all(40.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Main Page: mit dem Feld können Nummern gesucht werden\n unten soll Synchronisation mit sever angetriggert werden(Floating button)'),
              new TextField(
                decoration: new InputDecoration(labelText: "Enter your number"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            ],
          )
      ),
    );
  }
}