import 'dart:convert';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:metriccalculator/utils/repo/metric-dbconnections.dart';
import 'package:metriccalculator/utils/service/callService.dart';

class MetricService {
  List<Metric> metricList = List<Metric>();
  //List<Call> calllistMonthly = List<Call>();
  List<Metric> metricTargetListByName = List<Metric>();
  List<Metric> metricActualListByName = List<Metric>();
  T cast<T>(x) => x is T ? x : null;

  MetricService() {
    // There's a better way to do this, stay tuned.
    //loadCallFromJson();
    //  metricDbHelper.deleteAllData();
    // loadCallFromJson();
  }
  MetricDbHelper metricDbHelper = new MetricDbHelper();
  CallService callService = new CallService();
  insertMetric(Metric metric) async {
    metricDbHelper.insertMetric(metric);
  }

  loadCallFromJson() async {
    String data = await rootBundle.loadString('assets/metrics.json');
    List<Metric> list = new List();
    var jsonlist = jsonDecode(data.toString()) as List;
    jsonlist.forEach((e) {
      metricDbHelper.insertMetric(Metric.fromMap(e));
    });
  }

  Future<List<Metric>> getMetricList() async {
    List<Metric> metricFuture = await metricDbHelper.getMetricList();
    return metricFuture;
  }

  Future<List<Metric>> getMetricByNameAndTarget(String name) async {
    List<Metric> metricFuture =
        await metricDbHelper.getMetricByNameAndType(name, "target");
    metricFuture.forEach((element) {});
    return metricFuture;
  }

  Future<List<Metric>> getMetricByNameAndActual(String name) async {
    List<Metric> metricFuture =
        await metricDbHelper.getMetricByNameAndType(name, "actual");
    return metricFuture;
  }

  Future<Metric> getMetric(Metric metricc) async {
    // return Metric.fromObject(
    Metric metric = await metricDbHelper.getMetricByNameAndTypeAndTerm(metricc);

    return metric;
  }

  updateMetric(Metric metric) async {
    Metric metricupdated = await getMetric(metric);
    metricupdated.setTarget = metric.getTarget;
    metricDbHelper.updateMetric(metricupdated);
  }

  setAllMetricByActual() async {
    await setAverageCallAnsweringRateByMonthActual();
    await setAverageCallPerformanceByMonthActual();
    await setAverageCallQualityByMonthActual();
    await setAverageCallResolutionRateByMonthActual();
    await setAverageCallTimeByMonthActual();
    await setTotalCallsNumberByMonthActual();
  }

  setTotalCallsNumberByMonthActual() async {
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "TotalCallNumber", i, "actual");
      metricUpdate.setTarget =
          await (callService.getTotalCallsNumberByMonth(i));
      metricDbHelper.updateMetric(metricUpdate);
    }
  }

  setAverageCallAnsweringRateByMonthActual() async {
    print("set etme fonksiyonu");
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "CallAnsweringRate", i, "actual");
      metricUpdate.setTarget =
          await (callService.getAverageCallAnsweringRateByMonth(i));
      await metricDbHelper.updateMetric(metricUpdate);
    }
  }

  setAverageCallTimeByMonthActual() async {
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "CallTime", i, "actual");
      metricUpdate.setTarget = await (callService.getAverageCallTimeByMonth(i));
      metricDbHelper.updateMetric(metricUpdate);
    }
  }

  setAverageCallResolutionRateByMonthActual() async {
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "CallResolutionRate", i, "actual");
      metricUpdate.setTarget =
          await (callService.getAverageCallResolutionRateByMonth(i));
      metricDbHelper.updateMetric(metricUpdate);
    }
  }

  setAverageCallPerformanceByMonthActual() async {
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "CallPerformance", i, "actual");
      metricUpdate.setTarget =
          await (callService.getAverageCallPerformanceByMonth(i));
      metricDbHelper.updateMetric(metricUpdate);
    }
  }

  setAverageCallQualityByMonthActual() async {
    for (int i = 1; i < 13; i++) {
      Metric metricUpdate = await metricDbHelper.getMetricByNameAndTypeAndTermP(
          "CallQuality", i, "actual");
      metricUpdate.setTarget =
          await (callService.getAverageCallQualityByMonth(i));
      metricDbHelper.updateMetric(metricUpdate);
    }
  }
}
