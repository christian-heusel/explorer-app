// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queries.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Queries$Query$Station _$Queries$Query$StationFromJson(
    Map<String, dynamic> json) {
  return Queries$Query$Station()..ID = json['ID'] as int;
}

Map<String, dynamic> _$Queries$Query$StationToJson(
        Queries$Query$Station instance) =>
    <String, dynamic>{
      'ID': instance.ID,
    };

Queries$Query _$Queries$QueryFromJson(Map<String, dynamic> json) {
  return Queries$Query()
    ..getStations = (json['getStations'] as List)
        ?.map((e) => e == null
            ? null
            : Queries$Query$Station.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$Queries$QueryToJson(Queries$Query instance) =>
    <String, dynamic>{
      'getStations': instance.getStations?.map((e) => e?.toJson())?.toList(),
    };
