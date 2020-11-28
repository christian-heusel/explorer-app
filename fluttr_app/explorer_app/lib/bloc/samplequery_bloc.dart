import 'dart:async';

import 'package:artemis/client.dart';
import 'package:artemis/schema/graphql_response.dart';
import 'package:bloc/bloc.dart';
import 'package:explorer_app/api_gen/graphql_api.graphql.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:meta/meta.dart';

part 'samplequery_event.dart';
part 'samplequery_state.dart';

class SamplequeryBloc extends Bloc<SamplequeryEvent, SamplequeryState> {
  GlobalConfiguration cfg;
  ArtemisClient client;
  SamplequeryBloc() : super(SamplequeryEmpty());

  @override
  Stream<SamplequeryState> mapEventToState(
    SamplequeryEvent event,
  ) async* {
    if (this.cfg == null) {
      this.cfg = await GlobalConfiguration().loadFromAsset("api_settings");
    }
    if (this.client == null) {
      this.client = ArtemisClient(this.cfg.getValue("graphql_api_url"));
    }
    if (event is SamplequeryQueryApi) {
      final simpleQuery = GetTodosQuery();
      final simpleQueryResponse = await this.client.execute(simpleQuery);
      if (!simpleQueryResponse.hasErrors) {
        yield SamplequeryRequestSucessfull(simpleQueryResponse);
      } else {
        yield SamplequeryRequestFailed(simpleQueryResponse);
      }
    } else if (event is SamplequeryClearResult) {
      yield SamplequeryEmpty();
    }
  }
}
