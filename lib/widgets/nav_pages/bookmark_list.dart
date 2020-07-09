import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:dailyfactsng/widgets/fact_list.dart';
import 'package:flutter/material.dart';

class BookmarkList extends StatefulWidget {
  BookmarkList({Key key}) : super(key: key);

  @override
  _BookmarkListState createState() => new _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {


 FactBloc _factBloc;
  @override
  void initState() {
    super.initState();
    _factBloc = FactBloc(
      fetchType: FactListFetchType.bookmarkedFacts,
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