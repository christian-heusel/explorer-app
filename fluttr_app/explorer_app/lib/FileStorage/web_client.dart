// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:explorer_app/FileStorage/todo_entity.dart';
import 'package:explorer_app/models/answer.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  Future<List<TodoEntity>> fetchTodos() async {
    return Future.delayed(
        delay,
        () => [
              TodoEntity(
                  1,
                  AnswerTypes.text,
                  true,
                  'eins',
                  Answer(AnswerTypes.text, note:"antwort 1")
              ),
              TodoEntity(
                  2,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
             TodoEntity(
                  3,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  4,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  5,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  6,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  7,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  8,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  9,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  10,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  11,
                  AnswerTypes.text,
                  true,
                  'eins',
                  Answer(AnswerTypes.text, note:"antwort 11")
              ),
              TodoEntity(
                  12,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  13,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  14,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  15,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  16,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  17,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  18,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  19,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  20,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  21,
                  AnswerTypes.text,
                  true,
                  'eins',
                  Answer(AnswerTypes.text, note:"antwort 21")
              ),
              TodoEntity(
                  22,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  23,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                 24,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  25,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  26,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  27,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  28,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  29,
                  AnswerTypes.text,
                  false,'',
                  Answer(AnswerTypes.text)
              ),
              TodoEntity(
                  30,
                  AnswerTypes.text,
                  false,
                  'zwei',
                  Answer(AnswerTypes.text)
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }
}
