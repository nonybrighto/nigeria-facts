import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/fact_source.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:flutter/material.dart';

class FactDisplayPage extends StatefulWidget {
  final Fact fact;
  final FactBloc factBloc;
  FactDisplayPage({Key key, this.fact, this.factBloc}) : super(key: key);

  @override
  _FactDisplayPageState createState() => new _FactDisplayPageState();
}

class _FactDisplayPageState extends State<FactDisplayPage> {
  bool showSource = false;
  Fact fact;
  @override
  void initState() {
    super.initState();
    fact = widget.fact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(fact.title)),
        body: Column(
          children: <Widget>[
            Text(fact.description),
            IconButton(
              icon: Icon(Icons.favorite),
              color: fact.isBookmarked ? Colors.red : Colors.black,
              onPressed: () {
                // setState(() {
                //   fact.isBookmarked = !fact.isBookmarked;
                // });
                widget.factBloc.toggleBookmark(
                    fact: fact,
                    toggleCallback: (toggled) {
                      //send original unchanged fact
                      if (!toggled) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to bookmark fact'),
                        ));
                      }else{
                         setState(() {
                          // fact.isBookmarked = !fact.isBookmarked;
                        });
                      }
                    });
              },
            ),
            RaisedButton(
                child: Text('View Source'),
                onPressed: () {
                  setState(() {
                    showSource = !showSource;
                  });
                }),
            if (showSource)
              FutureBuilder<List<FactSource>>(
                  future: FactLocal(dbHelper: DatabaseHelper())
                      .getFactSources(widget.fact.id),
                  initialData: [],
                  builder: (context, factSourcesSnapshot) {
                    final factSources = factSourcesSnapshot.data;
                    return Column(children: <Widget>[
                      ...factSources
                          .map((source) => _buildSourceDisplay(source))
                    ]);
                  })
          ],
        ));
  }

  _buildSourceDisplay(source) {
    return Text(source.title);
  }
}
