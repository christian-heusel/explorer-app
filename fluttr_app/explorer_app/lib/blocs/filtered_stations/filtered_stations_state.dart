import 'package:equatable/equatable.dart';
import 'package:explorer_app/models/models.dart';

abstract class FilteredStationsState extends Equatable {
  const FilteredStationsState();

  @override
  List<Object> get props => [];
}

class FilteredStationsLoadInProgress extends FilteredStationsState {}

class FilteredStationsLoadSuccess extends FilteredStationsState {
  final List<Station> filteredStations;
  final VisibilityFilter activeFilter;

  const FilteredStationsLoadSuccess(
    this.filteredStations,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredStations, activeFilter];

  @override
  String toString() {
    return 'FilteredStationsLoadSuccess { filteredStations: $filteredStations, activeFilter: $activeFilter }';
  }
}
