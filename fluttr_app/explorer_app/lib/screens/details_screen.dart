import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/blocs/stations/stations.dart';
import 'package:explorer_app/screens/screens.dart';
import 'package:explorer_app/flutter_stations_keys.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.stationDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        final station = (state as StationsLoadSuccess)
            .stations
            .firstWhere((station) => station.id == id, orElse: () => null);
        final localizations = ArchSampleLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.stationDetails),
          ),
          body: station == null
              ? Container(key: FlutterStationsKeys.emptyDetailsContainer)
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Checkbox(
                                key: FlutterStationsKeys.detailsScreenCheckBox,
                                value: station.complete,
                                onChanged: (_) {
                                  /* BlocProvider.of<StationsBloc>(context).add(
                                    StationUpdated(
                                      station.copyWith(complete: !station.complete),
                                    ),
                                  );*/
                                }),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${station.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      station.id.toString(),
                                      key: ArchSampleKeys.detailsStationItemTask,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Text(
                                  station.userInput.toString(),
                                  key: ArchSampleKeys.detailsStationItemNote,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editStationFab,
            tooltip: localizations.editStation,
            child: Icon(Icons.edit),
            onPressed: station == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreen(
                            key: ArchSampleKeys.editStationScreen,
                            onSave: (complete, userInput) {
                              BlocProvider.of<StationsBloc>(context).add(
                                StationUpdated(
                                  station.copyWith(
                                      complete: complete, userInput: userInput),
                                ),
                              );
                            },
                            isEditing: true,
                            station: station,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
