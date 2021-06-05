import 'package:metriccalculator/utils/model/metric.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
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
    List metricList = new List<Metric>();
    var result =
        await db.rawQuery("SELECT * FROM $tblMetric ORDER BY $colId ASC");
    print(result.toList());
    result.toList().forEach((element) {
      //  metricList.add(Metric.fromJson(element.toString()));
      metricList.add(Metric.fromMap(element));
      //  print("bir de böyle deneyelim $element");
    });

    return metricList;
  }

  Future<Metric> getMetricById(int metricId) async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblMetric WHERE $colId=$metricId");
    Metric metric = Metric.fromMap(result.toList()[0]);
    print("metric geldi $metric");
    return metric;
  }

  Future getMetricByNameAndType(String name, String type) async {
    String metricName = name;
    String metricType = type;
    List metricList = new List<Metric>();
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblMetric WHERE $colMetricName = '$metricName' AND $colMetricType='$metricType'");
    result.toList().forEach((element) {
      metricList.add(Metric.fromMap(element));
    });
    return metricList;
  }

  Future getMetricByNameAndTypeAndTerm(Metric metric) async {
    String metricName = metric.getMetricName;
    String metricType = metric.getMetricType;
    int metricTerm = metric.getTerm;
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblMetric WHERE $colMetricName = $metricName AND $colMetricType=$metricType AND $colMetricTerm=$metricTerm");
    Metric metricc = Metric.fromMap(result.toList()[0]);
    return metricc;
  }

  Future getMetricByNameAndTypeAndTermP(
      String name, int term, String type) async {
    String metricName = name;
    String metricType = type;
    int metricTerm = term;
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblMetric WHERE $colMetricName = '$metricName' AND $colMetricType='$metricType' AND $colMetricTerm=$metricTerm");
    Metric metricc = Metric.fromMap(result.toList()[0]);
    return metricc;
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
