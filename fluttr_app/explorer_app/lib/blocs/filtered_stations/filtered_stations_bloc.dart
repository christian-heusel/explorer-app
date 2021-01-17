import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:explorer_app/blocs/filtered_stations/filtered_stations.dart';
import 'package:explorer_app/blocs/stations/stations.dart';
import 'package:explorer_app/models/models.dart';

class FilteredStationsBloc extends Bloc<FilteredStationsEvent, FilteredStationsState> {
  final StationsBloc stationsBloc;
  StreamSubscription stationsSubscription;

  FilteredStationsBloc({@required this.stationsBloc})
      : super(
          stationsBloc.state is StationsLoadSuccess
              ? FilteredStationsLoadSuccess(
                  (stationsBloc.state as StationsLoadSuccess).stations,
                  VisibilityFilter.all,
                )
              : FilteredStationsLoadInProgress(),
        ) {
    stationsSubscription = stationsBloc.listen((state) {
      if (state is StationsLoadSuccess) {
        add(StationsUpdated((stationsBloc.state as StationsLoadSuccess).stations));
      }
    });
  }

  @override
  Stream<FilteredStationsState> mapEventToState(FilteredStationsEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is StationsUpdated) {
      yield* _mapStationsUpdatedToState(event);
    }
  }

  Stream<FilteredStationsState> _mapFilterUpdatedToState(
    FilterUpdated event,
  ) async* {
    if (stationsBloc.state is StationsLoadSuccess) {
      yield FilteredStationsLoadSuccess(
        _mapStationsToFilteredStations(
          (stationsBloc.state as StationsLoadSuccess).stations,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredStationsState> _mapStationsUpdatedToState(
    StationsUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredStationsLoadSuccess
        ? (state as FilteredStationsLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredStationsLoadSuccess(
      _mapStationsToFilteredStations(
        (stationsBloc.state as StationsLoadSuccess).stations,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Station> _mapStationsToFilteredStations(
      List<Station> stations, VisibilityFilter filter) {
    return stations.where((station) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !station.complete;
      } else {
        return station.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    stationsSubscription.cancel();
    return super.close();
  }
}
