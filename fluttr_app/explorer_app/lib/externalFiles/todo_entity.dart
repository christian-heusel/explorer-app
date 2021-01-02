// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/answer.dart';

class TodoEntity extends Equatable {

  final int id;
  final int type;
  final bool complete;

  final String task;
  final Answer userInput;

  const TodoEntity( this.id, this.type, this.complete, this.task, this.userInput);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'type': type,
      'complete': complete,
      'task': task,
      'userInput': userInput,
    };
  }

  @override
  List<Object> get props => [ id, type, complete, task, userInput];

  @override
  String toString() {
    return 'TodoEntity {  id: $id, type:$type, complete: $complete, task: $task, }';
  }

  static TodoEntity fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      json['id'] as int,
      json['type'] as int,
      json['complete'] as bool,
      json['task'] as String,
      Answer.fromJson(json['userInput']),
    );
  }
}