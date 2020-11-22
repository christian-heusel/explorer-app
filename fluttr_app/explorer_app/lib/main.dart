import 'package:explorer_app/bloc/samplequery_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
        home: BlocProvider<SamplequeryBloc>(
          create: (context) => SamplequeryBloc(),
          child: MainPage(),
        ));
  }
}

class MainPage extends StatelessWidget {
  static const String _title = "Explorer 2021";

  @override
  Widget build(BuildContext context) {
    final SamplequeryBloc samplequeryBloc =
        BlocProvider.of<SamplequeryBloc>(context);
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
            Text(_title),
          ],
        ),
      ),
      body: BlocBuilder<SamplequeryBloc, SamplequeryState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    icon: ((state is SamplequeryEmpty)
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
                    onPressed: () {
                      if (state is SamplequeryEmpty) {
                        samplequeryBloc.add(SamplequeryQueryApi());
                      } else {
                        samplequeryBloc.add(SamplequeryClearResult());
                      }
                    }),
              ),
              Center(
                child: ((state is SamplequeryEmpty)
                    ? Text("")
                    : Text(state.response.data.todos[0].id)),
              ),
            ],
          );
        },
      ),
    );
  }
}
