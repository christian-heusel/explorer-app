// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }

  String get todos => Intl.message(
        'Todos',
        name: 'todos',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newTodoHint => Intl.message(
        'What needs to be done?',
        name: 'newTodoHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addTodo => Intl.message(
        'Add Todo',
        name: 'addTodo',
        args: [],
        locale: locale.toString(),
      );

  String get editTodo => Intl.message(
        'Edit Todo',
        name: 'editTodo',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterTodos => Intl.message(
        'Filter Todos',
        name: 'filterTodos',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTodo => Intl.message(
        'Delete Todo',
        name: 'deleteTodo',
        args: [],
        locale: locale.toString(),
      );

  String get todoDetails => Intl.message(
        'Todo Details',
        name: 'todoDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyTodoError => Intl.message(
        'Please enter some text',
        name: 'emptyTodoError',
        args: [],
        locale: locale.toString(),
      );

  String get notesHint => Intl.message(
        'Additional Notes...',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedTodos => Intl.message(
        'Completed Todos',
        name: 'completedTodos',
        args: [],
        locale: locale.toString(),
      );

  String get activeTodos => Intl.message(
        'Active Todos',
        name: 'activeTodos',
        args: [],
        locale: locale.toString(),
      );

  String todoDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'todoDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTodoConfirmation => Intl.message(
        'Delete this todo?',
        name: 'deleteTodoConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}

class ArchSampleKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addTodoFab = Key('__addTodoFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(int id) => Key('__snackbar_action_${id}__');

  // Todos
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');
  static final todoItem = (int id) => Key('TodoItem__${id}');
  static final todoItemCheckbox = (int id) => Key('TodoItem__${id}__Checkbox');
  static final todoItemTask = (int id) => Key('TodoItem__${id}__Task');
  static final todoItemNote = (int id) => Key('TodoItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const todoTab = Key('__todoTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editTodoFab = Key('__editTodoFab__');
  static const deleteTodoButton = Key('__deleteTodoFab__');
  static const todoDetailsScreen = Key('__todoDetailsScreen__');
  static final detailsTodoItemCheckbox = Key('DetailsTodo__Checkbox');
  static final detailsTodoItemTask = Key('DetailsTodo__Task');
  static final detailsTodoItemNote = Key('DetailsTodo__Note');

  // Add Screen
  static const addTodoScreen = Key('__addTodoScreen__');
  static const saveNewTodo = Key('__saveNewTodo__');
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editTodoScreen = Key('__editTodoScreen__');
  static const saveTodoFab = Key('__saveTodoFab__');
}
