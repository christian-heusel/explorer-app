import 'package:flutter/material.dart';

void main() {
  runApp(explorer_app());
}

class explorer_app extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explorer 2021',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  static const String _title = "Explorer 2021";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            new Image.asset(
              'images/logo_jungenschaft.png',
              width: 25.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(_title),
          ],
        ),
      ),
      body: Center(child: Text("Test")),
    );
  }
}
