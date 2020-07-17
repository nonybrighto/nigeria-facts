import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/category_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/pages/home_page.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<CategoryBloc>(
      bloc: CategoryBloc(factLocal: FactLocal(dbHelper: DatabaseHelper())),
        child: MaterialApp(
      title: 'DailyFactNG',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0XFFFFFFFF),
        iconTheme: IconThemeData(
          color: Colors.red
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: kTextColor)
        )
      ),
      home: HomePage(),
    ),
    );
  }
}
