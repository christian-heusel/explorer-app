import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/models.dart';

abstract class FilteredStationsEvent extends Equatable {
  const FilteredStationsEvent();
}

class FilterUpdated extends FilteredStationsEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class StationsUpdated extends FilteredStationsEvent {
  final List<Station> stations;

  const StationsUpdated(this.stations);

  @override
  List<Object> get props => [stations];

  @override
  String toString() => 'StationsUpdated { stations: $stations }';
}
