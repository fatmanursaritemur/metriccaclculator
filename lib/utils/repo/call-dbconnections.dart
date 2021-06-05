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
        "$colCustomerId TEXT,"
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
    print("uzunluk su:${result.toList().length}");
    result.toList().forEach((element) {
      //  print(element);
    });
    return result;
  }

  Future<List> getCallByMonth(int startTime, int endTime) async {
    Database db = await this.db;
    List callList = new List<Call>();
    var result = await db.rawQuery(
        "SELECT * FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    result.toList().forEach((element) {
      //  metricList.add(Metric.fromJson(element.toString()));
      callList.add(Call.fromMapToDb(element));
      //  print("bir de böyle deneyelim $element");
    });

    return callList;
  }

  Future<int> getTotalVruTimeByMonth(int startTime, int endTime) async {
    // çağrı karşılama hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colVruTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime");
    int value = result[0]["avg($colVruTime)"].toInt();
    return value;
  }

  deleteAllData() async {
    Database db = await this.db;
    var result = await db.rawQuery("DELETE from $tblCall ");
    return result;
  }

  Future<int> getTotalSerTimeByMonth(int startTime, int endTime) async {
    // çağrı süresi
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colSerTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["avg($colSerTime)"].toInt();
    return value;
  }

  Future<int> getTotalQTimeByMonth(int startTime, int endTime) async {
    // çağrı çözüm hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colQTime) FROM $tblCall WHERE $colDate>$startTime AND $colDate<$endTime ORDER BY $colPriority ASC");
    int value = result[0]["avg($colQTime)"].toInt();
    return value;
  }

  Future<int> getHangCountByMonth(int startTime, int endTime) async {
    // çağrı çözüm hızı
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT avg($colQTime) FROM $tblCall WHERE $colOutcome='HANG' ORDER BY $colPriority ASC");
    int value = result[0]["avg($colQTime)"].toInt();
    return value;
  }

  Future<Call> insertCall(Call call) async {
    Database db = await this.db;
    call.callId = await db.insert(tblCall, call.toMap());
    // print("insert etti");
    return call;
  }
}
