import 'dart:convert';

import 'package:metriccalculator/utils/model/call.dart';
import 'package:metriccalculator/utils/repo/call-dbconnections.dart';
import 'package:flutter/services.dart' show rootBundle;

class CallService {
  List<Call> callList = List<Call>();
  List<Call> calllistMonthly = List<Call>();

  CallService() {
    // There's a better way to do this, stay tuned.
    getCallList();
  }
  CallDbHelper callDbHelper = new CallDbHelper();

  loadCallFromJson() async {
    String data = await rootBundle.loadString('assets/aa.json');
    List<Call> list = new List();
    var jsonlist = jsonDecode(data.toString()) as List;
    jsonlist.forEach((e) {
      print(callDbHelper.insertCall(Call.fromMap(e)));
    });
  }

  getCallList() async {
    print("*********");
    final todosFuture = callDbHelper.getCall();
    todosFuture.then((result) {
      //List<Call> todoList = List<Call>();
      for (int i = 0; i < result.length; i++) {
        this.callList.add(Call.fromObject(result[i]));
        print(callList[i].server);
      }
    });
  }

  getCallListByMonth(int month) {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    final todosFuture = callDbHelper.getCallByMonth(startDate, endDate);
    todosFuture.then((result) {
      //List<Call> todoList = List<Call>();
      for (int i = 0; i < result.length; i++) {
        this.calllistMonthly.add(Call.fromObject(result[i]));
        print(callList[i].server);
      }
    });
  }

  int getTotalCallsNumberByMonth(int month) {
    getCallListByMonth(month);
    return this.calllistMonthly.length;
  }

  getAverageCallAnsweringRateByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalVruTimeByMonth(startDate, endDate);
    return averageCallTime;
  }

  getAverageCallTimeByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalSerTimeByMonth(startDate, endDate);
    return averageCallTime;
  }

  getAverageCallResolutionRateByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalQTimeByMonth(startDate, endDate);
    return averageCallTime;
  }

  getAverageCallPerformanceByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageHangCallTime =
        await callDbHelper.getHangCountByMonth(startDate, endDate);
    int callCountByMonth = getTotalCallsNumberByMonth(month);
    int callTimeByMonth = getAverageCallTimeByMonth(month);
    return (averageHangCallTime * 4 +
            callCountByMonth * 2 +
            callTimeByMonth * 4) /
        10;
  }

  getAverageCallQualityByMonth(int month) async {
    int averageCallAnswering = getAverageCallAnsweringRateByMonth(month);
    int averageCallPerformanceByMonth = getAverageCallPerformanceByMonth(month);
    int averageCallResolutionRateByMonth =
        getAverageCallResolutionRateByMonth(month);
    return (averageCallAnswering * 4 +
            averageCallPerformanceByMonth * 2 +
            averageCallResolutionRateByMonth * 4) /
        10;
  }
}
