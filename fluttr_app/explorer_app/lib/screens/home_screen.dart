import 'package:flutter/material.dart';

import 'package:explorer_app/externalFiles/ArchSample.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/blocs/blocs.dart';
import 'package:explorer_app/widgets/widgets.dart';
import 'package:explorer_app/localization.dart';
import 'package:explorer_app/models/models.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.stations),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.stations ? FilteredStations() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addStationFab,
            onPressed: () {
              Navigator.pushNamed(context, '/addStation');

              ///Archsample Routes?????????
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addStation,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
