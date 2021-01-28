import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/models/models.dart';

class StationItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Station station;

  StationItem({
    Key key,
    @required this.onTap,
    @required this.station,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ArchSampleKeys.stationItem(station.id),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.black87))),
          child: station.complete
              ? Icon(Icons.done, color: Colors.green)
              : Icon(
                  Icons.close,
                  color: Colors.red,
                ),
        ),
        title: Hero(
          tag: '${station.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Station ${station.id.toString()}",
              key: ArchSampleKeys.stationItemTask(station.id),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // TODO: This should display the Station Title
        subtitle: station.userInput.note.isNotEmpty
            ? Text(
                station.userInput.note,
                key: ArchSampleKeys.stationItemNote(station.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              )
            : null,
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      ),
    );
  }
}
