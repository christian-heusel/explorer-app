// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:explorer_app/FileStorage/todo_entity.dart';
import 'file_storage.dart';
import 'web_client.dart';

abstract class TodosRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<TodoEntity>> loadTodos();

  // Persists todos to local disk and the web
  Future saveTodos(List<TodoEntity> todos);
}

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class TodosRepositoryFlutter implements TodosRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TodosRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.fetchTodos();

      fileStorage.saveTodos(todos);

      return todos;
    }
  }

// Persists todos to local disk and the web
  @override
  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos),
    ]);
  }
}
