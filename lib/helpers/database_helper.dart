import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  Database _db;
  static const dbName = 'dailyfact.db';
  static const int databaseVersion = 1;

  DatabaseHelper();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      bool dbCreated = await _dbCreated();
      if (!dbCreated) {
        _db = await createFromAsset();
      } else {
        _db = await _openDb();
      }

      return _db;
    }
  }

  Future<String> _getDbPath() async {
    Directory path = await getApplicationDocumentsDirectory();
    return join(path.path, dbName);
  }

  Future<File> _writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<Database> createFromAsset() async {
      bool dbCreated = await _dbCreated();
      if (!dbCreated) {
        ByteData data = await rootBundle.load('assets/database/$dbName');
        String path = await _getDbPath();

        File file = await _writeToFile(data, path);
        Database db = await openDatabase(file.path,
            version: databaseVersion,
            onCreate: (database, version){
              
              _setDbCreated();
              
            },
            onUpgrade: (database, oldVersion, newVersion){
                  print('old is $oldVersion and new is $newVersion');
            },
            onOpen: (database) {
              print('the database is open');
            });

        return db;
      } else {
        return _openDb();
      }
  }

  Future<Database> _openDb() async {
    String path = await _getDbPath();
    Database db =
        await openDatabase(path, version: databaseVersion, onOpen: (database) {
      print('the database is open');
    });
    return db;
  }

  Future<bool> _dbCreated() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool created = pref.getBool('dbCreated') ?? false;
    return created;
  }

  _setDbCreated() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('dbCreated', true);
  }
}
