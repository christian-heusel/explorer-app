// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStations$Query$Station _$GetStations$Query$StationFromJson(
    Map<String, dynamic> json) {
  return GetStations$Query$Station()
    ..ID = json['ID'] as int
    ..title = json['title'] as String;
}

Map<String, dynamic> _$GetStations$Query$StationToJson(
        GetStations$Query$Station instance) =>
    <String, dynamic>{
      'ID': instance.ID,
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
