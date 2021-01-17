import 'package:equatable/equatable.dart';
import 'package:explorer_app/FileStorage/station_entity.dart';
import 'package:flutter/cupertino.dart';
import 'answer.dart';

class Station extends Equatable {
  //ID from Quest
  final int id;
  final int type; //which type of quest?

  final bool complete;
  //we neede date and time(in the future)

  final String task; //um die aufgabe zu beschreiben
  final Answer userInput;

  Station.fromScratch(
    this.id,
    this.type, {
    this.complete = false,
    this.task = '',
  }) : userInput = Answer(type);

  Station(this.id, this.type, this.complete, this.task, this.userInput);

  Station copyWith(
      {int id,
      AnswerTypes type,
      bool complete,
      String task,
      Answer userInput}) {
    return Station(
      id ?? this.id,
      type ?? this.type,
      complete ?? this.complete,
      task ?? this.task,
      userInput ?? this.userInput,
    );
  }

  @override
  List<Object> get props => [id, type, complete, task, userInput];

  @override
  String toString() {
    return 'Station { id: $id, complete: $complete, type: $type, task: $task, Answer: ' +
        userInput.toString() +
        '}';
  }

  StationEntity toEntity() {
    return StationEntity(
        this.id, this.type, this.complete, this.task, this.userInput);
  }

  static Station fromEntity(StationEntity entity) {
    return Station(
      entity.id,
      entity.type,
      entity.complete,
      entity.task,
      entity.userInput,
    );
  }
}
