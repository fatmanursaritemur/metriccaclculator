import 'dart:async';
import 'dart:io';
import 'package:metriccalculator/utils/model/call.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CallDbHelper {
  static final CallDbHelper _dbHelper = CallDbHelper._internal();
  String tblCall = "call_table";
  String colId = "call_id";
  String colCustomerId = "customer_id";
  String colVruLine = "vruline";
  String colPriority = "priority";
  String colType = "type";
  String colDate = "date";
  String colVruEntry = "vru_entry";
  String colVruExit = "vru_exit";
  String colVruTime = "vru_time";
  String colQStart = "q_start";
  String colQExit = "q_exit";
  String colQTime = "q_time";
  String colOutcome = "outcome";
  String colSerStart = "ser_start";
  String colSerExit = "ser_exit";
  String colSerTime = "ser_time";
  String colServer = "server";
  CallDbHelper._internal();

  factory CallDbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeCallDb();
    }
    return _db;
  }

  /*Future<Database> initalizeCallDb() async {
    print("buraya girdi");
   var dbDir = await getDatabasesPath();
    print("initalize etti");
    String path = dbDir.path + "todos.db";
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'calls.db'),
     
    print("databse geldi");
    return database;
  }*/

  Future<Database> initalizeCallDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "calls.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createCallDb);
    return dbTodos;
  }

  void _createCallDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE if not exists $tblCall ("
        "$colId INTEGER PRIMARY KEY,"
        "$colType TEXT, $colOutcome TEXT,"
        "$colServer TEXT,"
        "$colVruLine TEXT,"
        "$colCustomerId INTEGER,"
        "$colPriority INTEGER,"
        "$colDate INTEGER,"
        "$colVruEntry TEXT,"
        "$colVruExit TEXT,"
        "$colVruTime INTEGER,"
        "$colQStart TEXT,"
        "$colQExit TEXT,"
        "$colQTime INTEGER,"
        "$colSerStart TEXT,"
        "$colSerTime INTEGER,"
        "$colSerExit TEXT"
        ")");
  }

  Future<List> getCall() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblCall");
    print(result);
    return result;
  }

  Future<List> getCallByMonth(int startTime, int endTime) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    return result;
  }

  /*Future<int> getTotalVruEntryByMonth(int startTime, int endTime) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT Sum($colVruEntry) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["SUM($colVruEntry)"];
    return value;
  }

  Future<int> getTotalVruExitByMonth(int startTime, int endTime) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT Sum($colVruExit) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["SUM($colVruExit)"];
    return value;
  }*/

  Future<int> getTotalVruTimeByMonth(int startTime, int endTime) async { // çağrı karşılama hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colVruTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["avg($colVruTime)"];
    return value;
  }
  
  Future<int> getTotalSerTimeByMonth(int startTime, int endTime) async { // çağrı süresi
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colSerTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["avg($colSerTime)"];
    return value;
  }
  
  Future<int> getTotalQTimeByMonth(int startTime, int endTime) async { // çağrı çözüm hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colQTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["avg($colQTime)"];
    return value;
  }
  
  Future<int> getHangCountByMonth(int startTime, int endTime) async { // çağrı çözüm hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colQTime) FROM $tblCall WHERE $colOutcome='HANG' ORDER BY $colPriority ASC");
    int value = result[0]["avg($colQTime)"];
    return value;
  }

  Future<Call> insertCall(Call call) async {
    print("insert'e girdi");
    Database db = await this.db;
    print("db bolumunu geçri -- insert");
    call.callId = await db.insert(tblCall, call.toMap());
    print("insert etti");
    return call;
  }
}
