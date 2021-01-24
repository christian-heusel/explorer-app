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

  String get stations => Intl.message(
        'Stationen',
        name: 'stations',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Statistiken',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'alle anzeigen',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'aktive anzeigen',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'fertige anzeigen',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newStationHint => Intl.message(
        'Bitte gib deine Antwort ein',
        name: 'newStationHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'alle als beantwortet markieren',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'alle als zu erledigen markieren',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'beantwortete löschen',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addStation => Intl.message(
        'Neue Antwort hinzufügen',
        name: 'addStation',
        args: [],
        locale: locale.toString(),
      );

  String get editStation => Intl.message(
        'Antwort bearbeiten',
        name: 'editStation',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Änderungen speichern',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterStations => Intl.message(
        'Antworten filtern',
        name: 'filterStations',
        args: [],
        locale: locale.toString(),
      );

  String get deleteStation => Intl.message(
        'Antwort löschen',
        name: 'deleteStation',
        args: [],
        locale: locale.toString(),
      );

  String get stationDetails => Intl.message(
        'Details zur Antwort',
        name: 'stationDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyStationError => Intl.message(
        'Bitte gib einen Text ein ...',
        name: 'emptyStationError',
        args: [],
        locale: locale.toString(),
      );

  String get notesHint => Intl.message(
        'Zusätzliche notizen',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedStations => Intl.message(
        'Fertige Antworten',
        name: 'completedStations',
        args: [],
        locale: locale.toString(),
      );

  String get activeStations => Intl.message(
        'ausstehende Antworten',
        name: 'activeStations',
        args: [],
        locale: locale.toString(),
      );

  String stationDeleted(String task) => Intl.message(
        'Antwort "$task" gelöscht',
        name: 'stationDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Rückgängig machen',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteStationConfirmation => Intl.message(
        'Antwort wirklich löschen?',
        name: 'deleteStationConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'löschen',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Abbrechen',
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
  static const addStationFab = Key('__addStationFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(int id) => Key('__snackbar_action_${id}__');

  // Stations
  static const stationList = Key('__stationList__');
  static const stationsLoading = Key('__stationsLoading__');
  static final stationItem = (int id) => Key('StationItem__${id}');
  static final stationItemCheckbox =
      (int id) => Key('StationItem__${id}__Checkbox');
  static final stationItemTask = (int id) => Key('StationItem__${id}__Task');
  static final stationItemNote = (int id) => Key('StationItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const stationTab = Key('__stationTab__');
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
  static const editStationFab = Key('__editStationFab__');
  static const deleteStationButton = Key('__deleteStationFab__');
  static const stationDetailsScreen = Key('__stationDetailsScreen__');
  static final detailsStationItemCheckbox = Key('DetailsStation__Checkbox');
  static final detailsStationItemTask = Key('DetailsStation__Task');
  static final detailsStationItemNote = Key('DetailsStation__Note');

  // Add Screen
  static const addStationScreen = Key('__addStationScreen__');
  static const saveNewStation = Key('__saveNewStation__');
  static const taskField = Key('__taskField__');
  static const noteField = Key('__noteField__');

  // Edit Screen
  static const editStationScreen = Key('__editStationScreen__');
  static const saveStationFab = Key('__saveStationFab__');
}
