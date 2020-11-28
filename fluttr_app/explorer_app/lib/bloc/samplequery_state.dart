part of 'samplequery_bloc.dart';

@immutable
abstract class SamplequeryState {
  final GraphQLResponse<GetTodos$Query> response;
  SamplequeryState(this.response);
}

class SamplequeryEmpty extends SamplequeryState {
  SamplequeryEmpty() : super(null);
}

class SamplequeryRequestSucessfull extends SamplequeryState {
  SamplequeryRequestSucessfull(response) : super(response);
}

class SamplequeryRequestFailed extends SamplequeryState {
  SamplequeryRequestFailed(response) : super(response);
}
