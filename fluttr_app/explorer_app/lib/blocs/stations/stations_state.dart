import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/models.dart';

abstract class StationsState extends Equatable {
  const StationsState();

  @override
  List<Object> get props => [];
}

class StationsLoadInProgress extends StationsState {}

class StationsLoadSuccess extends StationsState {
  final List<Station> stations;

  const StationsLoadSuccess([this.stations = const []]);

  @override
  List<Object> get props => [stations];

  @override
  String toString() => 'StationsLoadSuccess { stations: $stations }';
}

class StationsLoadFailure extends StationsState {}
