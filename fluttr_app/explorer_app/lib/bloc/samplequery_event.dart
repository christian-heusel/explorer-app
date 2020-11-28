part of 'samplequery_bloc.dart';

@immutable
abstract class SamplequeryEvent {}

class SamplequeryQueryApi extends SamplequeryEvent {}

class SamplequeryClearResult extends SamplequeryEvent {}
