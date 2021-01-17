import 'package:explorer_app/auth/auth.dart';
import 'package:explorer_app/bloc/samplequery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/localization.dart';
import 'package:explorer_app/blocs/blocs.dart';
import 'package:explorer_app/screens/screens.dart';

import 'package:explorer_app/FileStorage/repository.dart';
import 'package:explorer_app/FileStorage/file_storage.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';

void main() {
  // We can set a Bloc's observer to an instance of `SimpleBlocObserver`.
  // This will allow us to handle all transitions and errors in SimpleBlocObserver.
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return StationsBloc(
          stationsRepository: const StationsRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(StationsLoaded());
      },
      child: StationsApp(),
    ),
  );
}

class StationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        '/': (context) {
          //ArchsampleRoutes TODO anpassen oder entfernen
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredStationsBloc>(
                create: (context) => FilteredStationsBloc(
                  stationsBloc: BlocProvider.of<StationsBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  stationsBloc: BlocProvider.of<StationsBloc>(context),
                ),
              ),
              BlocProvider<SamplequeryBloc>(
                  create: (context) => SamplequeryBloc()),
            ],
            child: HomeScreen(),
          );
        },
        /* '/addStation': (context) {   //ArchsampleRoutes TODO siehe oben
          return AddEditScreen(
            key: ArchSampleKeys.addStationScreen,
            onSave: (userInput) {
              BlocProvider.of<StationsBloc>(context).add(
                StationAdded(Station(task, note: note)),
              );
            },
            isEditing: false,
          );
        },*/
      },
    );
  }
}
