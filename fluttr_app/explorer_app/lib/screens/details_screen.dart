import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explorer_app/externalFiles/ArchSample.dart';
import 'package:explorer_app/blocs/stations/stations.dart';
import 'package:explorer_app/screens/screens.dart';
import 'package:explorer_app/flutter_stations_keys.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.stationDetailsScreen);

  topContent(context, station) => Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/explorer_logo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Center(
              child: topContentText(station),
            ),
          ),
          Positioned(
            left: 8.0,
            top: 60.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          )
        ],
      );

  topContentText(station) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60.0),
          Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 40.0,
          ),
          Container(
            width: 90.0,
            child: new Divider(color: Colors.green),
          ),
          SizedBox(height: 10.0),
          Text(
            "Station 5",
            style: TextStyle(color: Colors.white, fontSize: 45.0),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.place,
                  color: Colors.white70,
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Placeholder",
                        style: TextStyle(color: Colors.white),
                      ))),
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ))
            ],
          ),
        ],
      );

  bottomContentText(context, station) => Text(
        station.userInput.toString(),
        style: TextStyle(fontSize: 18.0),
      );

  bottomContent(context, station) => Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(40.0),
        child: Center(child: (bottomContentText(context, station))),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        final station = (state as StationsLoadSuccess)
            .stations
            .firstWhere((station) => station.id == id, orElse: () => null);
        final localizations = ArchSampleLocalizations.of(context);
        return Scaffold(
          body: Column(
            children: <Widget>[
              topContent(context, station),
              bottomContent(context, station),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editStationFab,
            tooltip: localizations.editStation,
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddEditScreen(
                      key: ArchSampleKeys.editStationScreen,
                      onSave: (complete, userInput) {
                        BlocProvider.of<StationsBloc>(context).add(
                          StationUpdated(
                            station.copyWith(
                                complete: complete, userInput: userInput),
                          ),
                        );
                      },
                      isEditing: true,
                      station: station,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
