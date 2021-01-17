import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/models.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();

  @override
  List<Object> get props => [];
}

class StationsLoaded extends StationsEvent {}

class StationAdded extends StationsEvent {
  final Station station;

  const StationAdded(this.station);

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'StationAdded { station: $station }';
}

class StationUpdated extends StationsEvent {
  final Station station;

  const StationUpdated(this.station);

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'StationUpdated { updatedStation: $station }';
}

class StationDeleted extends StationsEvent {
  final Station station;

  const StationDeleted(this.station);

  @override
  List<Object> get props => [station];

  @override
  String toString() => 'StationDeleted { station: $station }';
}

class ClearCompleted extends StationsEvent {}

class ToggleAll extends StationsEvent {}
