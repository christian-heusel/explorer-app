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
          return GridView.builder(
            key: ArchSampleKeys.stationList,
            itemCount: stations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    2.5), //TODO better rotatio (problem with high resolution)
            itemBuilder: (BuildContext context, int index) {
              final station = stations[index];
              return StationItem(
                station: station,
                onTap: () async {
                  final removedStation = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: station.id);
                    }),
                  );
                },
              );
            },
          );
        } else {
          return Container(key: FlutterStationsKeys.filteredStationsEmptyContainer);
        }
      },
    );
  }
}
