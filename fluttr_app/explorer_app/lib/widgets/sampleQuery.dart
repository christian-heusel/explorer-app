import 'package:flutter/material.dart';
import 'package:explorer_app/bloc/samplequery_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class sampleQuery extends StatelessWidget {
  sampleQuery({Key key}) : super(key: key);
  Widget build(BuildContext context) {
    final SamplequeryBloc samplequeryBloc =
        BlocProvider.of<SamplequeryBloc>(context);

    return Container(
      child: BlocBuilder<SamplequeryBloc, SamplequeryState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    icon: ((state is SamplequeryEmpty)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 24.0,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.blue,
                            size: 24.0,
                          )),
                    color: Colors.red[500],
                    onPressed: () {
                      if (state is SamplequeryEmpty) {
                        samplequeryBloc.add(SamplequeryQueryApi());
                      } else {
                        samplequeryBloc.add(SamplequeryClearResult());
                      }
                    }),
              ),
              Center(
                child: ((state is SamplequeryEmpty)
                    ? Text("")
                    : Text("Titel der Station: " +
                        state.response.data.getStations[0].title.toString())),
              ),
            ],
          );
        },
      ),
    );
  }
}
