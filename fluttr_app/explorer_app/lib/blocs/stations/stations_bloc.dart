import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:explorer_app/blocs/stations/stations.dart';
import 'package:explorer_app/models/models.dart';
import 'package:explorer_app/FileStorage/repository.dart';
import 'package:explorer_app/FileStorage/station_entity.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final StationsRepositoryFlutter stationsRepository;

  StationsBloc({@required this.stationsRepository})
      : super(StationsLoadInProgress());

  @override
  Stream<StationsState> mapEventToState(StationsEvent event) async* {
    if (event is StationsLoaded) {
      yield* _mapStationsLoadedToState();
    } else if (event is StationAdded) {
      yield* _mapStationAddedToState(event);
    } else if (event is StationUpdated) {
      yield* _mapStationUpdatedToState(event);
    } else if (event is StationDeleted) {
      yield* _mapStationDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<StationsState> _mapStationsLoadedToState() async* {
    try {
      final stations = await this.stationsRepository.loadStations();
      yield StationsLoadSuccess(
        stations.map(Station.fromEntity).toList(),
      );
    } catch (_) {
      yield StationsLoadFailure();
    }
  }

  Stream<StationsState> _mapStationAddedToState(StationAdded event) async* {
    if (state is StationsLoadSuccess) {
      final List<Station> updatedStations =
          List.from((state as StationsLoadSuccess).stations)
            ..add(event.station);
      yield StationsLoadSuccess(updatedStations);
      _saveStations(updatedStations);
    }
  }

  Stream<StationsState> _mapStationUpdatedToState(StationUpdated event) async* {
    if (state is StationsLoadSuccess) {
      final List<Station> updatedStations =
          (state as StationsLoadSuccess).stations.map((station) {
        return station.id == event.station.id ? event.station : station;
      }).toList();
      yield StationsLoadSuccess(updatedStations);
      _saveStations(updatedStations);
    }
  }

  Stream<StationsState> _mapStationDeletedToState(StationDeleted event) async* {
    if (state is StationsLoadSuccess) {
      final updatedStations = (state as StationsLoadSuccess)
          .stations
          .where((station) => station.id != event.station.id)
          .toList();
      yield StationsLoadSuccess(updatedStations);
      _saveStations(updatedStations);
    }
  }

  Stream<StationsState> _mapToggleAllToState() async* {
    if (state is StationsLoadSuccess) {
      final allComplete = (state as StationsLoadSuccess)
          .stations
          .every((station) => station.complete);
      final List<Station> updatedStations = (state as StationsLoadSuccess)
          .stations
          .map((station) => station.copyWith(complete: !allComplete))
          .toList();
      yield StationsLoadSuccess(updatedStations);
      _saveStations(updatedStations);
    }
  }

  Stream<StationsState> _mapClearCompletedToState() async* {
    if (state is StationsLoadSuccess) {
      final List<Station> updatedStations = (state as StationsLoadSuccess)
          .stations
          .where((station) => !station.complete)
          .toList();
      yield StationsLoadSuccess(updatedStations);
      _saveStations(updatedStations);
    }
  }

  Future _saveStations(List<Station> stations) {
    return stationsRepository.saveStations(
      stations.map((station) => station.toEntity()).toList(),
    );
  }
}
