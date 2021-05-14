import 'dart:convert';

import 'package:metriccalculator/utils/model/call.dart';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:metriccalculator/utils/repo/call-dbconnections.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:metriccalculator/utils/repo/metric-dbconnections.dart';

class MetricService {
  List<Metric> metricList = List<Metric>();
  //List<Call> calllistMonthly = List<Call>();

  MetricService() {
    // There's a better way to do this, stay tuned.
    getMetricList();
  }
  MetricDbHelper metricDbHelper = new MetricDbHelper();

  insertMetric(Metric metric) async {
    metricDbHelper.insertMetric(metric);
  }

  getMetricList() async {
    print("*********");
    final metricFuture = metricDbHelper.getMetricList();
    metricFuture.then((result) {
      //List<Call> todoList = List<Call>();
      for (int i = 0; i < result.length; i++) {
        this.metricList.add(Metric.fromObject(result[i]));
      }
    });
  }

  Metric getMetric(Metric metricc) {
    return Metric.fromObject(
        metricDbHelper.getMetricByNameAndTypeAndTerm(metricc));
  }

  updateMetric(Metric metric) {
    Metric metricupdated = getMetric(metric);
    metricupdated.setTarget = metric.getTarget;
    metricDbHelper.updateMetric(metricupdated);
  }
}
