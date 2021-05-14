import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metriccalculator/pages/calories_section/calories_section.dart';
import 'package:metriccalculator/pages/header_info.dart';
import 'package:metriccalculator/pages/heart_rate/heart_rate.dart';
import 'package:metriccalculator/pages/heart_rate/heart_rate_section.dart';
import 'package:metriccalculator/pages/meals_section/meals.dart';
import 'package:metriccalculator/pages/meals_section/meals_section.dart';
import 'package:metriccalculator/pages/sections.dart';
import 'package:metriccalculator/pages/sleep_section/sleep_section.dart';
import 'package:metriccalculator/pages/water_section/water_section.dart';
import 'package:metriccalculator/utils/model/call.dart';
import 'package:metriccalculator/utils/model/metric.dart';

import '../utils/service/callService.dart';
import 'workout_section/workout_section.dart';

class MainPage extends StatefulWidget {
  static String tag = 'main-page';
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  CallService callService = new CallService();
  saveBigList() async {
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
  }

  saveBigLis2t() async {
    String data = await DefaultAssetBundle.of(context).loadString("/aa.json");
    List<Call> list = new List();
    var jsonlist = jsonDecode(data) as List;
    jsonlist.forEach((e) {
      list.add(Call.fromMap(e));
    });
    print(list[0].qExit);
  }

  @override
  Widget build(BuildContext context) {
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
                          child: SleepSection(),
                        ),
                        Sections(
                          widthFull: _widthFull,
                          child: WaterSection(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Sections(
                          widthFull: _widthFull,
                          child: InkWell(
                            onTap: () async {
                              // callService.loadCallFromJson(
                              //     await DefaultAssetBundle.of(context)
                              //         .loadString("/aa.json"));
                              //callService.getCallList();
                              callService.loadCallFromJson();
                              callService.getCallList();
                            },
                            child: CaloriesSection(),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(HeartRatePage.tag);
                          },
                          child: Sections(
                            widthFull: _widthFull,
                            child: HeartRate(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Sections(
                          widthFull: _widthFull,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(MealsPage.tag);
                            },
                            child: MealsSection(),
                          ),
                        ),
                        Sections(
                          widthFull: _widthFull,
                          child: WorkoutSection(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomBar(),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Material(
        child: Container(
          width: double.infinity,
          height: 70.0,
          color: Color(0xFFEAEAEA),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BottomButton(
                  imgPath: 'assets/images/four-squares.png',
                  index: 10,
                  isPlus: false,
                  isTapped: true,
                ),
                BottomButton(
                  imgPath: 'assets/images/first-aid.png',
                  index: 9,
                  isPlus: false,
                  isTapped: false,
                ),
                BottomButton(
                  imgPath: 'assets/images/add.png',
                  index: 2,
                  isPlus: true,
                  isTapped: false,
                ),
                BottomButton(
                  imgPath: 'assets/images/dumbbell.png',
                  index: 3,
                  isPlus: false,
                  isTapped: false,
                ),
                BottomButton(
                  imgPath: 'assets/images/user.png',
                  index: 4,
                  isPlus: false,
                  isTapped: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String imgPath;
  final int index;
  final bool isTapped;
  final bool isPlus;

  MainPageState mainPageState = new MainPageState();

  BottomButton({this.imgPath, this.index, this.isTapped, this.isPlus});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      //shape: CircleBorder(),
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: isPlus
              ? Colors.white
              : isTapped
                  ? Colors.grey
                  : Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            print(index);
          },
          child: Image.asset(
            imgPath,
            width: 30.0,
          ),
        ),
      ),
    );
  }
}
