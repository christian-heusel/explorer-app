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
                  false,
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
             /*TodoEntity(
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
              ),*/
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }
}
