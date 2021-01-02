// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import "package:explorer_app/externalFiles/todo_entity.dart";
import 'package:explorer_app/models/todo.dart';
//import 'package:explorer_app/models/answer.dart';

abstract class TodosRepository {
  Future<void> addNewTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Stream<List<Todo>> todos();

  Future<void> updateTodo(Todo todo);
}

/*
class Todo {
  final int id;
  final int type; //which type of quest?

  final bool complete;
  //we neede date and time(in the future)

  final String task; //um die aufgabe zu beschreiben
  final Answer userInput;

  Todo.fromScratch(
      this.id,
      this.type, {
        this.complete = false,
        this.task = '',
      }): userInput = Answer(type);

  Todo(this.id,
      this.type,
      this.complete,
      this.task,
      this.userInput
      );

  Todo copyWith({int id, int type, bool complete,String task, Answer userInput}) {
    return Todo(
      id ?? this.id,
      type ?? this.type,
      complete ?? this.complete,
      task ?? this.task,
      userInput ?? this.userInput,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ type.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
              runtimeType == other.runtimeType &&
              complete == other.complete &&
              task == other.task &&
              type == other.type &&
              id == other.id;

  @override
  String toString() {
    return 'Todo { id: $id, complete: $complete, type: $type, task: $task, Answer: '+ userInput.toString() +'}';
  }

  TodoEntity toEntity() {
    return TodoEntity(this.id, this.type, this.complete, this.task, this.userInput);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.id,
      entity.type,
      entity.complete,
      entity.task,
      entity.userInput,
    );
  }
}
*/