import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dailyfactsng/bloc/list_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/fact_list_response.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

class FactBloc extends ListBloc<Fact> {
  final FactLocal factLocal;
  final FactListFetchType fetchType;
  final Category category;
  String searchTerm;
  bool singleItem;

  final _currentFactController = BehaviorSubject<Fact>();
  final _showNotificationController = BehaviorSubject<bool>();
  final _factsPerDayController = BehaviorSubject<int>();

  Stream<Fact> get currentFact => _currentFactController.stream;
  Stream<bool> get showNotification => _showNotificationController.stream;
  Stream<int> get factsPerDay => _factsPerDayController.stream;

  FactBloc(
      {this.factLocal,
      @required this.fetchType,
      this.category,
      this.singleItem = false}) {
    searchTerm = '';
    if (fetchType != null) {
      getItems();
    }
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  _init() async {
    try {
      if (!await factLocal.initialized()) {
        await _setNotificationAlarm(await factLocal.getFactsPerDay());
        factLocal.initialize();
      }
    } catch (error) {
      print('init failed'); //log
    }
    _getshowNotification();
    _getFactsPerDay();
  }

  _getshowNotification() async {
    bool showNotification = await factLocal.getShowNotification();
    _showNotificationController.add(showNotification);
  }

  _getFactsPerDay() async {
    int factsPerDay = await factLocal.getFactsPerDay();
    _factsPerDayController.add(factsPerDay);
  }

  void toggleShowNotification() async {
    bool toggledValue = await factLocal.toggleShowNotification();
    _showNotificationController.add(toggledValue);
    if (toggledValue == false) {
      AndroidAlarmManager.cancel(kFactAlarmId);
    } else {
      _setNotificationAlarm(await factLocal.getFactsPerDay());
    }
  }

  void changeFactsPerDay(int newValue) async {
    await factLocal.setFactsPerDay(newValue);
    _factsPerDayController.add(newValue);

    if (newValue > 0) {
      _setNotificationAlarm(newValue);
    } else {
      AndroidAlarmManager.cancel(kFactAlarmId);
    }
  }

  _setNotificationAlarm(int numberPerDay) async {
    await AndroidAlarmManager.periodic(
        Duration(minutes: (24 * 60 / numberPerDay).ceil()),
        kFactAlarmId,
        displayNotification);
  }

  searchFact(String searchTerm) {
    this.searchTerm = searchTerm;
    this.currentPage = 1;
    getItems();
  }

  setCurrentFact(Fact fact) {
    _currentFactController.add(fact);
  }

  toggleBookmark({Fact fact, Function(bool toggled) toggleCallback}) async {
    try {
      fact.isBookmarked = !fact.isBookmarked;
      if (!singleItem) {
        updateItem(fact);
      }
      _currentFactController.add(fact);
      await factLocal.toggleFactBookmark(fact.id, fact.isBookmarked);
      if (toggleCallback != null) {
        toggleCallback(true);
      }
    } catch (error) {
      fact.isBookmarked = !fact.isBookmarked;
      if (!singleItem) {
        updateItem(fact);
      }
      _currentFactController.add(fact);
      if (toggleCallback != null) {
        toggleCallback(false);
      }
    }
  }

  shareFact({Fact fact, Function(bool shared) shareCallback}) async {
    String title, content = '';
    try {
      title = '${fact.title}';
      content =
          '${fact.description} \n Get more amazing facts from $kAppName - $kStoreLink';

      final cacheManager = DefaultCacheManager();
      File file = await cacheManager.getSingleFile(fact.imageUrl);
      final fileBytes = await file.readAsBytes();
      await Share.file(title, '$kAppName.jpg', fileBytes, 'image/jpg',
          text: content);
      shareCallback(true);
    } on OSError {
      Share.text(title, content, 'text/plain');
      shareCallback(true);
    } catch (error) {
      shareCallback(false);
    }
  }

  @override
  Future<FactListResponse> fetchFromServer() async {
    switch (fetchType) {
      case FactListFetchType.randomFacts:
        return await factLocal.getRandomFacts(page: currentPage);
        break;
      case FactListFetchType.bookmarkedFacts:
        return await factLocal.getBookMarkedFacts(page: currentPage);
      case FactListFetchType.categoryFacts:
        return await factLocal.getCategoryFacts(
            category: category, page: currentPage);
      case FactListFetchType.searchFacts:
        return await factLocal.getSearchedFacts(
            searchTerm: searchTerm, page: currentPage);
      default:
        return null;
    }
  }

  _dispose() {
    _currentFactController.close();
    _factsPerDayController.close();
    _showNotificationController.close();
  }

  @override
  bool itemIdentificationCondition(Fact currentFact, Fact updatedFact) {
    return currentFact.id == updatedFact.id;
  }

  @override
  String getEmptyResultMessage() {
    return 'No Fact found';
  }
}

enum FactListFetchType {
  randomFacts,
  bookmarkedFacts,
  categoryFacts,
  searchFacts
}
