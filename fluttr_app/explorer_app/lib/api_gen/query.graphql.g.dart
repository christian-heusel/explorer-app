// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStations$Query$Station _$GetStations$Query$StationFromJson(
    Map<String, dynamic> json) {
  return GetStations$Query$Station()
    ..ID = json['ID'] as int
    ..points = json['points'] as int
    ..station_type = json['station_type'] as int
    ..coordinates = json['coordinates'] as String
    ..grid_square = json['grid_square'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$GetStations$Query$StationToJson(
        GetStations$Query$Station instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'points': instance.points,
      'station_type': instance.station_type,
      'coordinates': instance.coordinates,
      'grid_square': instance.grid_square,
      'title': instance.title,
    };

GetStations$Query _$GetStations$QueryFromJson(Map<String, dynamic> json) {
  return GetStations$Query()
    ..getStations = (json['getStations'] as List)
        ?.map((e) => e == null
            ? null
            : GetStations$Query$Station.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GetStations$QueryToJson(GetStations$Query instance) =>
    <String, dynamic>{
      'getStations': instance.getStations?.map((e) => e?.toJson())?.toList(),
    };
