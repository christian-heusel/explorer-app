import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/models/models.dart';
import 'package:explorer_app/models/answer.dart';

typedef OnSaveCallback = Function(bool complete, Answer userInput);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Station station;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.station,
  }) : super(key: key ?? ArchSampleKeys.addStationScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editStation : localizations.addStation,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.station.id.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              TextFormField(
                initialValue: isEditing ? widget.station.userInput.note : '',
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: localizations.notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveStationFab : ArchSampleKeys.saveNewStation,
        tooltip: isEditing ? localizations.saveChanges : localizations.addStation,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(
                _note.isNotEmpty, Answer(widget.station.type, note: _note));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
