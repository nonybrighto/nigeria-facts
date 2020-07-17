import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:dailyfactsng/widgets/fact_list.dart';
import 'package:dailyfactsng/widgets/general/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CategoryFactsPage extends StatefulWidget {

  final Category category;
  CategoryFactsPage({this.category});

  @override
  _CategoryFactsPageState createState() => _CategoryFactsPageState();
}

class _CategoryFactsPageState extends State<CategoryFactsPage> {

   FactBloc _factBloc;
  @override
  void initState() {
    super.initState();
    _factBloc = FactBloc(
      fetchType: FactListFetchType.categoryFacts,
      category: widget.category,
      factLocal: FactLocal(dbHelper: DatabaseHelper())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: Text(widget.category.name),),
      body: BlocProvider<FactBloc>(
            bloc: _factBloc,
            child: FactList(),
          ),
    );
  }
}