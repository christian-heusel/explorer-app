// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class GetStations$Query$Station with EquatableMixin {
  GetStations$Query$Station();

  factory GetStations$Query$Station.fromJson(Map<String, dynamic> json) =>
      _$GetStations$Query$StationFromJson(json);

  int ID;

  String title;

  @override
  List<Object> get props => [ID, title];
  Map<String, dynamic> toJson() => _$GetStations$Query$StationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetStations$Query with EquatableMixin {
  GetStations$Query();

  factory GetStations$Query.fromJson(Map<String, dynamic> json) =>
      _$GetStations$QueryFromJson(json);

  List<GetStations$Query$Station> getStations;

  @override
  List<Object> get props => [getStations];
  Map<String, dynamic> toJson() => _$GetStations$QueryToJson(this);
}

class GetStationsQuery
    extends GraphQLQuery<GetStations$Query, JsonSerializable> {
  GetStationsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'getStations'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'getStations'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'ID'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'title'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'getStations';

  @override
  List<Object> get props => [document, operationName];
  @override
  GetStations$Query parse(Map<String, dynamic> json) =>
      GetStations$Query.fromJson(json);
}
