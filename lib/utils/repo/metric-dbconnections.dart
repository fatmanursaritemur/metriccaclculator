import 'package:metriccalculator/utils/model/metric.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class MetricDbHelper {
  static final MetricDbHelper _dbHelper = MetricDbHelper._internal();
  String tblMetric = "call_metric";
  String colId = "metricId";
  String colMetricName = "metricName";
  String colTarget = "target";
  String colMetricType = "metricType";
  String colMetricTerm = "term";

  MetricDbHelper._internal();

  factory MetricDbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeMetricDb();
    }
    return _db;
  }

  Future<Database> initalizeMetricDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "metrics.db";
    var dbTodos =
        await openDatabase(path, version: 1, onCreate: _createMetricDb);
    return dbTodos;
  }

  void _createMetricDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblMetric($colId INTEGER PRIMARY KEY, $colMetricName TEXT, $colTarget INTEGER, $colMetricType TEXT, $colMetricTerm INTEGER)");
  }

  Future<int> insertMetric(Metric metric) async {
    Database db = await this.db;
    var result = await db.insert(tblMetric, metric.toMap());
    return result;
  }

  Future<List> getMetricList() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblMetric ORDER BY $colId ASC");
    return result;
  }

  Future getMetricById(int metricId) async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblMetric WHERE $colId=$metricId");
    return result;
  }

  Future getMetricByNameAndTypeAndTerm(Metric metric) async {
    String metricName = metric.getMetricName;
    String metricType = metric.getMetricType;
    int metricTerm = metric.getTerm;
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblMetric WHERE $colMetricName = $metricName AND $colMetricType=$metricType AND $colMetricTerm=$metricTerm");
    return result;
  }

  Future<List<String>> getEmptyMetric() async {
    Database db = await this.db;
    List<String> result = (await db
            .rawQuery("SELECT metricName FROM $tblMetric WHERE $colTarget=0"))
        .cast<String>();
    return result;
  }

  Future<int> updateMetric(Metric metric) async {
    var db = await this.db;
    var result = await db.update(tblMetric, metric.toMap(),
        where: "$colId = ?", whereArgs: [metric.metricId]);
    return result;
  }
}
