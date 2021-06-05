import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metriccalculator/pages/calories_section/calories.dart';
import 'package:metriccalculator/pages/calories_section/calories_section.dart';
import 'package:metriccalculator/pages/header_info.dart';
import 'package:metriccalculator/pages/sections.dart';
import 'package:metriccalculator/utils/model/call.dart';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:metriccalculator/utils/service/metricService.dart';

import '../utils/service/callService.dart';

class MainPage extends StatefulWidget {
  static String tag = 'main-page';

  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  CallService callService = new CallService();
  MetricService metricService = new MetricService();
  /*  saveBigList() async {
    String data = await DefaultAssetBundle.of(context).loadString("/aa.json");
    //List jsonList = jsonResult.map((Call call) => call.toJson()).toList();
    // print(jsonResult);
    // print(jsonList);
    //print(Metric.fromMap(jsonDecode(data)));
    //List<Metric> list = List<Metric>.from(parsed.map((i) => Example.fromJson(i)));
    List<Metric> list = new List();
    var jsonlist = jsonDecode(data) as List;
    jsonlist.forEach((e) {
      list.add(Metric.fromMap(e));
    });
    //  print(list);
    //print(jsonList);
  }*/

  /* saveBigLis2t() async {
    String data = await DefaultAssetBundle.of(context).loadString("/aa.json");
    List<Call> list = new List();
    var jsonlist = jsonDecode(data) as List;
    jsonlist.forEach((e) {
      list.add(Call.fromMap(e));
    });
    print(list[0].qExit);
  }*/

  @override
  Widget build(BuildContext context) {
    metricService.getMetricList();
    //  metricService.getMetricByNameAndActual("CallResolutionRate");
    // callService.getCallList();
    var _widthFull = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    HeaderInfo(
                      isMain: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Sections(
                            widthFull: _widthFull,
                            child: InkWell(
                              onTap: () async {
                                Navigator.of(context)
                                    .pushNamed(CaloriesPage.tag);
                                // callService.loadCallFromJson(
                                //     await DefaultAssetBundle.of(context)
                                //         .loadString("/aa.json"));
                                //callService.getCallList();
                                //callService.loadCallFromJson();
                                //  callService.getCallList();
                              },
                              child: CaloriesSection(),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
