
import 'package:equatable/equatable.dart';
import 'package:explorer_app/FileStorage/todo_entity.dart';
import 'answer.dart';


class Todo extends Equatable {
  //ID from Quest
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


  Todo copyWith({int id, AnswerTypes type, bool complete,String task, Answer userInput}) {
    return Todo(
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
