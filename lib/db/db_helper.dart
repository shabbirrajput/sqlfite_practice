import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'package:sqlite_practice/models/user_model.dart';

class DbHelper {
  late Database _db;

  static const String dbName = 'Demo.db';
  static const String tableUser = 'User';
  static const int version = 1;

  static const String userId = 'Id';
  static const String userName = 'Name';
  static const String userEmailAddress = 'Email Address';
  static const String userMobileNo = 'Mobile No';
  static const String userPassword = 'Password';

  Future<Database> get db async {
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        "$userId INTEGER PRIMARY KEY,"
        "$userName TEXT,"
        "$userEmailAddress TEXT,"
        "$userMobileNo TEXT,"
        "$userPassword TEXT"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, user.toJson());
    return res;
  }
}
