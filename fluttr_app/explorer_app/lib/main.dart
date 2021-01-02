import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/localization.dart';
import 'package:explorer_app/blocs/blocs.dart';
import 'package:explorer_app/models/models.dart';
import 'package:explorer_app/screens/screens.dart';

import 'package:explorer_app/externalFiles/repository/repository.dart';
import 'package:explorer_app/externalFiles/repository/file_storage.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';

void main() {
  // We can set a Bloc's observer to an instance of `SimpleBlocObserver`.
  // This will allow us to handle all transitions and errors in SimpleBlocObserver.
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return TodosBloc(
          todosRepository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TodosLoaded());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
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
        '/': (context) {    //ArchsampleRoutes TODO anpassen oder entfernen
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) => FilteredTodosBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
       /* '/addTodo': (context) {   //ArchsampleRoutes TODO siehe oben
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (userInput) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoAdded(Todo(task, note: note)),
              );
            },
            isEditing: false,
          );
        },*/
      },
    );
  }
}