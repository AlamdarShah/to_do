import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../homePage.dart';
import '../model/model.dart';

class DBhelper {
  final _databaseName = "to_do";
  final _databaseVersion = 1;
  static final _tableName = "item";
  final _columnId = "id";
  static final _columnName = "name";
  static final _columnDescription = "description";

  //private constructor
  DBhelper._constructor();
  static final DBhelper instance = DBhelper._constructor();

  static var _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initdatabase();
    return _database;
  }

  initdatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = await join(documentDirectory.path, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database database, version) async {
        return await database.execute(
            'CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$_columnName  TEXT,$_columnDescription TEXT)');
      },
    );
  }

  // Insert Data
  static Future<int> insert(MyItem item) async {
    Database database = await instance.database;
    Map<String, dynamic> row = {
      _columnName: item.name,
      _columnDescription: item.description
    };
    return database.insert(_tableName, row);
  }

  // Query on Table
  static readData() async {
    Database database = await instance.database;
    return database.query(_tableName);
  }
  static  Future deleteData(MyItem myitem)async{
    Database database = await instance.database;
    return database.execute("DELETE FROM $_tableName where id=${myitem.id}");
  }
}
