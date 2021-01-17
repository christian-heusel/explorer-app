// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:explorer_app/FileStorage/station_entity.dart';
import 'package:explorer_app/models/answer.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Stations to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Stations from a "web service" after a short delay
  Future<List<StationEntity>> fetchStations() async {
    return Future.delayed(
        delay,
        () => [
              StationEntity(1, AnswerTypes.text, true, 'eins',
                  Answer(AnswerTypes.text, note: "antwort 1")),
              StationEntity(
                  2, AnswerTypes.text, false, 'zwei', Answer(AnswerTypes.text)),
              StationEntity(
                  3, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  4, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  5, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  6, AnswerTypes.text, false, 'zwei', Answer(AnswerTypes.text)),
              StationEntity(
                  7, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  8, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  9, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(10, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(11, AnswerTypes.text, true, 'eins',
                  Answer(AnswerTypes.text, note: "antwort 11")),
              StationEntity(12, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(
                  13, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  14, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  15, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(16, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(
                  17, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  18, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  19, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(20, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(21, AnswerTypes.text, true, 'eins',
                  Answer(AnswerTypes.text, note: "antwort 21")),
              StationEntity(22, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(
                  23, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  24, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  25, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(26, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
              StationEntity(
                  27, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  28, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(
                  29, AnswerTypes.text, false, '', Answer(AnswerTypes.text)),
              StationEntity(30, AnswerTypes.text, false, 'zwei',
                  Answer(AnswerTypes.text)),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postStations(List<StationEntity> stations) async {
    return Future.value(true);
  }
}
