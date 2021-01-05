import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/models/models.dart';

class TodoItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Todo todo;

  TodoItem({
    Key key,
    @required this.onTap,
    @required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ArchSampleKeys.todoItem(todo.id),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.todoItemCheckbox(todo.id),
          value: todo.complete,
          onChanged: (bool placeholder){},
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.id.toString(),
              key: ArchSampleKeys.todoItemTask(todo.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: todo.userInput.note.isNotEmpty
            ? Text(
                todo.userInput.note,
                key: ArchSampleKeys.todoItemNote(todo.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
