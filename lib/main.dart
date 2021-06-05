import 'package:flutter/material.dart';
import 'package:metriccalculator/pages/calories_section/calories.dart';
import 'package:metriccalculator/pages/main_page.dart';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:metriccalculator/utils/repo/call-dbconnections.dart';
import 'package:metriccalculator/utils/service/metricService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final pages = <String, WidgetBuilder>{
    MainPage.tag: (context) => MainPage(),
    CaloriesPage.tag: (context) => CaloriesPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Oswald',
      ),
      home: MainPage(),
      routes: pages,
    );
  }
}
