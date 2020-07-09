import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/pages/fact_display_page.dart';
import 'package:flutter/material.dart';

class FactCard extends StatelessWidget {
  final Fact fact;
  FactCard({this.fact});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(children: [
        Text('hello from ' + fact.title),
        IconButton(
          icon: Icon(Icons.favorite),
          color: fact.isBookmarked ? Colors.red : Colors.black,
          onPressed: () {
            BlocProvider.of<FactBloc>(context).toggleBookmark(
                fact: fact,
                toggleCallback: (toggled) {
                  if (!toggled) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to bookmark fact'),
                    ));
                  }
                });
          },
        )
      ]),
      onTap: () {
        FactBloc _factBloc = BlocProvider.of<FactBloc>(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FactDisplayPage(
                  fact: fact,
                  factBloc: _factBloc,
                )));
      },
    );
  }
}
