import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:explorer_app/blocs/blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StationsBloc stationsBloc;
  StreamSubscription stationsSubscription;

  StatsBloc({@required this.stationsBloc}) : super(StatsLoadInProgress()) {
    void onStationsStateChanged(state) {
      if (state is StationsLoadSuccess) {
        add(StatsUpdated(state.stations));
      }
    }

    onStationsStateChanged(stationsBloc.state);
    stationsSubscription = stationsBloc.listen(onStationsStateChanged);
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      final numActive =
          event.stations.where((station) => !station.complete).toList().length;
      final numCompleted =
          event.stations.where((station) => station.complete).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    stationsSubscription.cancel();
    return super.close();
  }
}
