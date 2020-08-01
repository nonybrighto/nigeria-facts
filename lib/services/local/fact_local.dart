import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/helpers/pagination.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/fact_list_response.dart';
import 'package:dailyfactsng/models/fact_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class FactLocal {
  DatabaseHelper dbHelper;

  final String tableQuestions = 'Questions';

  FactLocal({this.dbHelper});


  Future<bool> initialized() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(kInitializedPrefKey) ?? false;
  }
 

  Future<void> initialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(kInitializedPrefKey, true);
  }

  Future<void> setFactsPerDay(int factsPerDay) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(kFactsPerDayPrefKey, factsPerDay);
  }
  Future<bool> toggleShowNotification() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
    bool showNotification = await getShowNotification();
    await pref.setBool(kShowNotificationPrefKey, !showNotification);
    return !showNotification;
  }

  Future<int> getFactsPerDay() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(kFactsPerDayPrefKey) ?? kFactsPerDay;
  }
  Future<bool> getShowNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(kShowNotificationPrefKey) ?? true;
  }

  Future<FactListResponse> getBookMarkedFacts({int page}) async {
    return _handleFactFetch(
        queryCallback: (db, limit, offset) {
          return Future.wait([
            db.rawQuery('SELECT COUNT(*) FROM Facts WHERE isBookmarked = 1'),
            db.rawQuery(
                'SELECT * FROM Facts WHERE isBookmarked = 1 LIMIT ? OFFSET ?',
                [limit, offset])
          ]);
        },
        page: page,
        errorMessage: 'Error while getting bookmarked facts');
  }

  Future<FactListResponse> getRandomFacts(
      {int page, List<int> alreadyGotten}) async {
    return _handleFactFetch(
        queryCallback: (db, limit, offset) {
          return Future.wait([
            db.rawQuery('SELECT COUNT(*) FROM Facts'),
            db.rawQuery(
                'SELECT * FROM Facts ORDER BY RANDOM() LIMIT ? OFFSET ?',
                [limit, offset])
          ]);
        },
        page: page,
        errorMessage: 'Failed to get random facts');
  }

  Future<Fact> getRandomFact() async {
    Database db = await dbHelper.db;
    final results = await db.rawQuery(
      'SELECT * FROM Facts ORDER BY RANDOM() LIMIT 1',
    );
    return Fact.fromJson(results[0]);
  }

  Future<Fact> getFact(factId) async {
      Database db = await dbHelper.db;
      final results = await db.rawQuery(
        'SELECT * FROM Facts WHERE id = ?', [factId]
      );
      return Fact.fromJson(results[0]);
  }

  Future<FactListResponse> getCategoryFacts(
      {int page, Category category}) async {
    return _handleFactFetch(
        queryCallback: (db, limit, offset) {
          return Future.wait([
            db.rawQuery(
                'SELECT COUNT(*) FROM Facts WHERE categoryId = ${category.id}'),
            db.rawQuery(
                'SELECT * FROM Facts WHERE categoryId = ${category.id} ORDER BY RANDOM() LIMIT ? OFFSET ?',
                [limit, offset])
          ]);
        },
        page: page,
        errorMessage: 'Failed to get random facts');
  }

  Future<FactListResponse> getSearchedFacts(
      {int page, String searchTerm}) async {
    return _handleFactFetch(
        queryCallback: (db, limit, offset) {
          return Future.wait([
            db.rawQuery('SELECT COUNT(*) FROM Facts WHERE summary LIKE ?',
                ["%$searchTerm%"]),
            db.rawQuery(
                'SELECT * FROM Facts WHERE summary LIKE ? ORDER BY RANDOM() LIMIT ? OFFSET ?',
                ["%$searchTerm%", limit, offset])
          ]);
        },
        page: page,
        errorMessage: 'Failed to get searched facts');
  }

  Future<void> toggleFactBookmark(String factId, bool bookmark) async {
    Database db = await dbHelper.db;
    String bookmarkValueString = bookmark ? "1" : "0";
    await db.rawUpdate(
        "UPDATE Facts SET isBookmarked = $bookmarkValueString WHERE id = ?",
        [factId]);
  }

  Future<List<Category>> getAllCategories() async {
    Database db = await dbHelper.db;
    final categoriesMaps = await db.rawQuery("SELECT * FROM Categories");
    if (categoriesMaps.length > 0) {
      return categoriesMaps
          .map((category) => Category.fromJson(category))
          .toList();
    }
    return [];
  }

  Future<List<FactSource>> getFactSources(String factId) async {
    Database db = await dbHelper.db;
    final sourcesMaps =
        await db.rawQuery("SELECT * FROM FactSources WHERE factId = $factId");
    if (sourcesMaps.length > 0) {
      return sourcesMaps
          .map((sources) => FactSource.fromJson(sources))
          .toList();
    }
    return [];
  }

  Future<FactListResponse> _handleFactFetch(
      {Function(Database db, int limit, int offset) queryCallback,
      String errorMessage,
      int page}) async {
    try {
      Database db = await dbHelper.db;
      List<Map<String, dynamic>> factsMaps;

      Pagination pagination = new Pagination(page: page);

      print(pagination.limit);

      final results =
          await queryCallback(db, pagination.limit, pagination.getOffset());
      pagination.setTotalCount(Sqflite.firstIntValue(results[0]));
      factsMaps = results[1];

      return FactListResponse(
          currentPage: pagination.page,
          totalPages: pagination.getTotalPages(),
          results: factsMaps.map((fact) => Fact.fromJson(fact)).toList());
    } catch (err) {
      print(err);
      throw Exception(errorMessage ?? 'Errror fetching facts');
    }
  }
}
