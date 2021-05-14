import 'package:flutter/material.dart';
import 'package:metriccalculator/pages/calories_section/calories.dart';
import 'package:metriccalculator/pages/heart_rate/heart_rate.dart';
import 'package:metriccalculator/pages/main_page.dart';
import 'package:metriccalculator/pages/meals_section/meals.dart';
import 'package:metriccalculator/utils/repo/call-dbconnections.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // CallDbHelper callDbHelper = new CallDbHelper();
  final pages = <String, WidgetBuilder>{
    MainPage.tag: (context) => MainPage(),
    CaloriesPage.tag: (context) => CaloriesPage(),
    MealsPage.tag: (context) => MealsPage(),
    HeartRatePage.tag: (context) => HeartRatePage(),
  };

  @override
  Widget build(BuildContext context) {
    // callDbHelper.initalizeCallDb();
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
