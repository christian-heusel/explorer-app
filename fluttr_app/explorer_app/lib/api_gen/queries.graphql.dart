// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'queries.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Queries$Query$Station with EquatableMixin {
  Queries$Query$Station();

  factory Queries$Query$Station.fromJson(Map<String, dynamic> json) =>
      _$Queries$Query$StationFromJson(json);

  int ID;

  @override
  List<Object> get props => [ID];
  Map<String, dynamic> toJson() => _$Queries$Query$StationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Queries$Query with EquatableMixin {
  Queries$Query();

  factory Queries$Query.fromJson(Map<String, dynamic> json) =>
      _$Queries$QueryFromJson(json);

  List<Queries$Query$Station> getStations;

  @override
  List<Object> get props => [getStations];
  Map<String, dynamic> toJson() => _$Queries$QueryToJson(this);
}

class QueriesQuery extends GraphQLQuery<Queries$Query, JsonSerializable> {
  QueriesQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: null,
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
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'queries';

  @override
  List<Object> get props => [document, operationName];
  @override
  Queries$Query parse(Map<String, dynamic> json) =>
      Queries$Query.fromJson(json);
}
