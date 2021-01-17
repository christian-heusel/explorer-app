import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Station> stations;

  const StatsUpdated(this.stations);

  @override
  List<Object> get props => [stations];

  @override
  String toString() => 'UpdateStats { stations: $stations }';
}
