import 'dart:convert';
import 'dart:math';

import 'package:metriccalculator/utils/model/call.dart';
import 'package:metriccalculator/utils/repo/call-dbconnections.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:metriccalculator/utils/repo/metric-dbconnections.dart';

class CallService {
  List<Call> callList = List<Call>();
  List<Call> calllistMonthly = List<Call>();

  CallService() {
    //callDbHelper.deleteAllData();
    // loadCallFromJson();
    //  getCallList();
  }
  CallDbHelper callDbHelper = new CallDbHelper();
  loadCallFromJson() async {
    String data = await rootBundle.loadString('assets/new.json');
    List<Call> list = new List();
    var jsonlist = jsonDecode(data.toString()) as List;
    print("json'un uzunluğu ${jsonlist.length}");
    jsonlist.forEach((e) {
      callDbHelper.insertCall(Call.fromMap(e));
    });
    print("************************");
    print("eklemeler bitttiii");
    print("************************");
  }

  getCallList() async {
    final todosFuture = callDbHelper.getCall();
    todosFuture.then((result) {
      //List<Call> todoList = List<Call>();
      for (int i = 0; i < result.length; i++) {
        this.callList.add(Call.fromObject(result[i]));
        //  print(callList[i].server);
      }
    });
  }

  Future<List<Call>> getCallListByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;

    List todosFuture = await callDbHelper.getCallByMonth(startDate, endDate);
    /*todosFuture.then((result) {
      //List<Call> todoList = List<Call>();
      for (int i = 0; i < result.length; i++) {
        this.calllistMonthly.add(Call.fromObject(result[i]));
        print(callList[i].server);
      }
    });*/
    return todosFuture;
  }

  Future<int> getTotalCallsNumberByMonth(int month) async {
    List<Call> callList = await getCallListByMonth(month);

    //return this.calllistMonthly.length;
    return ((callList.length + 10000) / 100).toInt();
  }

  Future<int> getAverageCallAnsweringRateByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalVruTimeByMonth(startDate, endDate);
    return (averageCallTime * 5);
  }

  Future<int> getAverageCallTimeByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalSerTimeByMonth(startDate, endDate);
    return ((averageCallTime * 2) / 5).toInt();
  }

  Future<int> getAverageCallResolutionRateByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageCallTime =
        await callDbHelper.getTotalQTimeByMonth(startDate, endDate);
    return (averageCallTime).toInt();
  }

  Future<int> getAverageCallPerformanceByMonth(int month) async {
    int startDate = 990000 + month * 100;
    int endDate = 990000 + (month + 1) * 100;
    int averageHangCallTime =
        await callDbHelper.getHangCountByMonth(startDate, endDate);
    int callCountByMonth = await getTotalCallsNumberByMonth(month);
    int callTimeByMonth = await getAverageCallTimeByMonth(month);
    int result = ((averageHangCallTime * 5 +
                callCountByMonth * 1 +
                callTimeByMonth * 5) /
            30)
        .toInt();
    return result;
  }

  Future<int> getAverageCallQualityByMonth(int month) async {
    int averageCallAnswering = await getAverageCallAnsweringRateByMonth(month);
    int averageCallPerformanceByMonth =
        await getAverageCallPerformanceByMonth(month);
    int averageCallResolutionRateByMonth =
        await getAverageCallResolutionRateByMonth(month);
    int result = ((averageCallAnswering * 4 +
                averageCallPerformanceByMonth * 2 +
                averageCallResolutionRateByMonth) /
            60)
        .toInt();
    return result;
  }
}
