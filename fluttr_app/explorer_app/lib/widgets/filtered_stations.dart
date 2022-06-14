import 'package:explorer_app/models/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/blocs/blocs.dart';
import 'package:explorer_app/widgets/widgets.dart';
import 'package:explorer_app/screens/screens.dart';
import 'package:explorer_app/flutter_stations_keys.dart';

class FilteredStations extends StatelessWidget {
  FilteredStations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredStationsBloc, FilteredStationsState>(
      builder: (context, state) {
        if (state is FilteredStationsLoadInProgress) {
          return LoadingIndicator(key: ArchSampleKeys.stationsLoading);
        } else if (state is FilteredStationsLoadSuccess) {
          final stations = state.filteredStations;
          return StationList(stations: stations);
        } else {
          return Container(
              key: FlutterStationsKeys.filteredStationsEmptyContainer);
        }
      },
    );
  }
}

class StationList extends StatelessWidget {
  const StationList({
    Key key,
    @required this.stations,
  }) : super(key: key);

  final List<Station> stations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: ArchSampleKeys.stationList,
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        final station = stations[index];
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
            child: StationItem(
              station: station,
              onTap: () async {
                final removedStation = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    // Directly go to the edit screen for stations that have not yet been completed
                    if (!station.complete) {
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
                    } else {
                      return DetailsScreen(id: station.id);
                    }
                  }),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
