import 'package:flutter/material.dart';
import 'subPageTest.dart';
import 'homePage.dart';
import 'openTaskPage.dart';
import 'closedTaskPage.dart';


import 'package:explorer_app/bloc/samplequery_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
        home:
          statefullMainPage()
    );
  }
}

class statefullMainPage extends StatefulWidget {
  statefullMainPage({Key key}) : super(key: key);
  String title = "Explorer 2021";
  @override
  MainPage createState() => MainPage();
}


class MainPage extends State<statefullMainPage> {

  final Key keyOne = PageStorageKey('sqlTest');
  final Key keyTwo = PageStorageKey('homePage');
  final Key keythree = PageStorageKey('openTasks');
  final Key keyFour = PageStorageKey('closedTasks');

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> pages;
  Widget currentPage;

  subPageTest testSqlPage;
  HomePage homeView;
  OpenTaskPage openTaskView;
  ClosedTaskPage closedTaskview;


 final PageStorageBucket bucket = PageStorageBucket(); //SS: needed, but don't know why


  void initState() {
    testSqlPage = subPageTest(key: keyOne);
    homeView = HomePage(key: keyTwo);
    openTaskView = OpenTaskPage(key: keythree);
    closedTaskview = ClosedTaskPage(key: keyFour);

    pages = <Widget>[testSqlPage, homeView, openTaskView, closedTaskview];
    currentPage = testSqlPage;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            new Image.asset(
              'assets/images/logo_jungenschaft.png',
              width: 25.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.title),
          ],
        ),
      ),

      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.adb),
            label: 'Test Site',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Mainview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'OpenPoint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            label: 'Closed Points ',
          ),
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}


