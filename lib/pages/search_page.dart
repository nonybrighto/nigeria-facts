import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:dailyfactsng/widgets/fact_list.dart';
import 'package:dailyfactsng/widgets/general/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FactBloc _factBloc;
  @override
  void initState() {
    super.initState();
    _factBloc = FactBloc(
        fetchType: FactListFetchType.searchFacts,
        factLocal: FactLocal(dbHelper: DatabaseHelper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(
          title: TextField(
            onChanged: (text) {
              _factBloc.searchFact(text);
            },
          ),
            actions: <Widget>[
            IconButton(icon: Icon(Icons.cancel), onPressed: (){
              Navigator.pop(context);
            })
          ],
        ),
        body: BlocProvider<FactBloc>(
          bloc: _factBloc,
          child: FactList(),
        ));
  }
}
