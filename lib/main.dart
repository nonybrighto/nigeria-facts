import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/pages/fact_display_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/category_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/pages/home_page.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final dbHelper = DatabaseHelper();
final factLocal = FactLocal(dbHelper: dbHelper);
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void displayNotification() async {
  try {
    Fact randomFact = await factLocal.getRandomFact();
    BigPictureStyleInformation bigPictureStyleInformation;
    try {
      final cacheManager = DefaultCacheManager();
      File file = await cacheManager.getSingleFile(randomFact.imageUrl);

      bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(file.path),
          largeIcon: FilePathAndroidBitmap(file.path),
          contentTitle: randomFact.title,
          htmlFormatContentTitle: true,
          summaryText: randomFact.summary);
    } catch (error) {
      bigPictureStyleInformation = null;
    }
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id', 'name', 'description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);

    await flutterLocalNotificationsPlugin.show(
        0, randomFact.title, randomFact.summary, platformChannelSpecifics,
        payload: randomFact.id);
  } catch (error) {
    print('log error');
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettings =
      InitializationSettings(initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      Fact factToShow = await factLocal.getFact(int.parse(payload));
      print(factToShow.title);
      navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => FactDisplayPage(
            fact: factToShow,
            factBloc: FactBloc(factLocal: factLocal, fetchType: null, singleItem: true),
          ),
        ),
      );
    }
  });
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
        navigatorKey: navigatorKey,
        title: 'DailyFactNG',
        theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Color(0XFFFFFFFF),
            iconTheme: IconThemeData(color: Colors.red),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(bodyText2: TextStyle(color: kTextColor))),
        home: HomePage(),
      ),
    );
  }
}
