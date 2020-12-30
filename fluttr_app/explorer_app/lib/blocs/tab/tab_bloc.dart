import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:explorer_app/blocs/tab/tab.dart';
import 'package:explorer_app/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
