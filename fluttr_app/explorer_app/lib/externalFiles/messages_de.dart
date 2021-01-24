// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'de';

  static String m0(task) => '"${task}" gelöscht!';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'activeStations':
            MessageLookupByLibrary.simpleMessage('unfertige Stationen'),
        'addStation':
            MessageLookupByLibrary.simpleMessage('Antwort hinzufügen'),
        'cancel': MessageLookupByLibrary.simpleMessage('Abbrechen'),
        'clearCompleted':
            MessageLookupByLibrary.simpleMessage('erledigte entfernen!'),
        'completedStations':
            MessageLookupByLibrary.simpleMessage('beantwortete Stationen'),
        'delete': MessageLookupByLibrary.simpleMessage('Löschen'),
        'deleteStation':
            MessageLookupByLibrary.simpleMessage('Antwort löschen'),
        'deleteStationConfirmation':
            MessageLookupByLibrary.simpleMessage('Antwort wirklich löschen?'),
        'editStation':
            MessageLookupByLibrary.simpleMessage('Antwort bearbeiten'),
        'emptyStationError':
            MessageLookupByLibrary.simpleMessage('Bitte gib einen text ein!'),
        'filterStations':
            MessageLookupByLibrary.simpleMessage('Stationen filtern'),
        'markAllComplete':
            MessageLookupByLibrary.simpleMessage('alle erledigen'),
        'markAllIncomplete':
            MessageLookupByLibrary.simpleMessage('Mark all incomplete'),
        'newStationHint': MessageLookupByLibrary.simpleMessage(
            'Bitte gib hier deine Antwort ein ..'),
        'notesHint': MessageLookupByLibrary.simpleMessage(
            'Hier den Antworttext eingeben ...'),
        'saveChanges':
            MessageLookupByLibrary.simpleMessage('Änderungen speichern'),
        'showActive': MessageLookupByLibrary.simpleMessage('zu beantworten'),
        'showAll': MessageLookupByLibrary.simpleMessage('alle anzeigen'),
        'showCompleted':
            MessageLookupByLibrary.simpleMessage('erledigte anzeigen'),
        'stats': MessageLookupByLibrary.simpleMessage('Statistiken'),
        'stationDeleted': m0,
        'stationDetails':
            MessageLookupByLibrary.simpleMessage('Antwortdetails'),
        'stations': MessageLookupByLibrary.simpleMessage('Stationen'),
        'undo': MessageLookupByLibrary.simpleMessage('Rückgängig machen')
      };
}
