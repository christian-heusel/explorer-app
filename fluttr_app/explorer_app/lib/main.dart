import 'package:explorer_app/api_gen/graphql_api.graphql.dart';
import 'package:flutter/material.dart';
import 'package:artemis/artemis.dart';

void main() {
  runApp(ExplorerApp());
}

class ExplorerApp extends StatelessWidget {
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

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const String _title = "Explorer 2021";
  bool _isFavorited = true;
  int _favoriteCount = 41;
  String _queryResult = "";

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
              width: 10,
            ),
            Text(_title),
          ],
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              icon: (_isFavorited
                  ? Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                    )
                  : Icon(
                      Icons.favorite,
                      color: Colors.blue,
                      size: 24.0,
                    )),
              color: Colors.red[500],
              onPressed: _toggleFavorite,
            ),
          ),
          Center(
            child: Text(_queryResult),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite() async {
    final client = ArtemisClient(
      'http://joeryzen.fritz.box:8000/query',
    );
    final simpleQuery = GetTodosQuery();
    final simpleQueryResponse = await client.execute(simpleQuery);
    client.dispose();

    setState(() {
      if (_isFavorited) {
        _queryResult = simpleQueryResponse.data.todos[0].id;
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _queryResult = "";
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}
