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

  static const String userId = 'id';
  static const String userName = 'name';
  static const String userEmailAddress = 'email';
  static const String userMobileNo = 'mobile';
  static const String userPassword = 'password';

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

  ///Insert Data
  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, user.toJson());
    return res;
  }

  ///Check User Data
  Future<UserModel> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        '''SELECT * FROM $tableUser WHERE $userEmailAddress = '$email' AND $userPassword = '$password' ''');

    if (res.isNotEmpty) {
      return UserModel.fromJson(res.first);
    }
    return UserModel();
  }

  ///Check User Email
  Future<UserModel> getEmailCheck(String email) async {
    try {
      var dbClient = await db;
      var res = await dbClient.rawQuery(
          '''SELECT * FROM $tableUser WHERE "$userEmailAddress" = "$email" ''');

      if (res.isNotEmpty) {
        return UserModel.fromJson(res.first);
      }
    } catch (e) {
      return UserModel();
    }
    return UserModel();
  }
}
