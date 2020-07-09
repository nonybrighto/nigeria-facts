import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:dailyfactsng/widgets/fact_list.dart';
import 'package:flutter/material.dart';

class HomeFactList extends StatefulWidget {
  HomeFactList({Key key}) : super(key: key);

  @override
  _HomeFactListState createState() => new _HomeFactListState();
}

class _HomeFactListState extends State<HomeFactList> {


 FactBloc _factBloc;
  @override
  void initState() {
    super.initState();
    _factBloc = FactBloc(
      fetchType: FactListFetchType.randomFacts,
      factLocal: FactLocal(dbHelper: DatabaseHelper())
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FactBloc>(
            bloc: _factBloc,
            child: FactList(),
          );
  }
}