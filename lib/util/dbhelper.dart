import 'package:runpa/model/challenge_run.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tableChallengeRunCalendar = "challenge_run_calendar";

  String colId = "id";
  String colDescription = "description";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "runpa.db";
    var dbRunpa = await openDatabase(path, version: 1, onCreate: _onCreateDb);
    return dbRunpa;
  }

  void _onCreateDb(Database db, int newVersion) async {
    await db.execute("""
          CREATE TABLE $tableChallengeRunCalendar(
            $colId INTEGER PRIMARY KEY, 
            $colDescription TEXT,
            date TEXT
          )
        """);
  }

  Future<int?> insertChallengeRun(ChallengeRun challengeRun) async {
    Database? db = await this.db;
    var result =
        await db?.insert(tableChallengeRunCalendar, challengeRun.toMap());
    return result;
  }

  Future<List<Map<String, Object?>>?> getChallengeRuns() async {
    Database? db = await this.db;
    var result = await db
        ?.rawQuery("select * from $tableChallengeRunCalendar order by $colId");

    return result;
  }

  Future<int?> getCount() async {
    Database? db = await this.db;
    var result = Sqflite.firstIntValue(await (db
            ?.rawQuery("select count(*) from $tableChallengeRunCalendar") ??
        Future.value([])));
    return result;
  }

  Future<int?> updateChallengeRun(ChallengeRun challengeRun) async {
    Database? db = await this.db;
    var result = await db?.update(
        tableChallengeRunCalendar, challengeRun.toMap(),
        where: "$colId = ?", whereArgs: [challengeRun.id]);
    return result;
  }

  Future<int?> deleteChallengeRun(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete(
        "delete from $tableChallengeRunCalendar where $colId = $id");
    return result;
  }
}
