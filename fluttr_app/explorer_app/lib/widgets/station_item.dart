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
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.stationItemCheckbox(station.id),
          value: station.complete,
          onChanged: (bool placeholder) {},
        ),
        title: Hero(
          tag: '${station.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              station.id.toString(),
              key: ArchSampleKeys.stationItemTask(station.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: station.userInput.note.isNotEmpty
            ? Text(
                station.userInput.note,
                key: ArchSampleKeys.stationItemNote(station.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
