import 'dart:async';

import 'package:explorer_app/FileStorage/station_entity.dart';
import 'package:explorer_app/models/answer.dart';

import 'package:artemis/client.dart';
import 'package:global_configuration/global_configuration.dart';


import 'package:explorer_app/api_gen/query.graphql.dart';


class ServerAccess{
  GlobalConfiguration cfg;
  ArtemisClient client;
  ServerAccess();


  Future<List<StationEntity>> fetchStations() async {
    if (this.cfg == null) {
      this.cfg = await GlobalConfiguration().loadFromAsset("api_settings");
    }
    if (this.client == null) {
      this.client = ArtemisClient(this.cfg.getValue("graphql_api_url"));
    }

    final simpleQuery = GetStationsQuery();
    final simpleQueryResponse = await this.client.execute(simpleQuery);
    if (!simpleQueryResponse.hasErrors) {
      List<StationEntity> stations = List<StationEntity>();
       simpleQueryResponse.data.getStations.forEach((element) {
         stations.add(StationEntity(element.ID, element.station_type, false, element.title, Answer(element.station_type)));
       });
       return stations;

    }
    else {
      return [];
    }

  }

  Future<bool> postStations(List<StationEntity> stations) async {
    return Future.value(true);
  }

}