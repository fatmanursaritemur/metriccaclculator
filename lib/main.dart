import 'package:flutter/material.dart';
import 'package:metriccalculator/pages/metric.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final pages = <String, WidgetBuilder>{
    MetricPage.tag: (context) => MetricPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Oswald',
      ),
      home: MetricPage(),
      routes: pages,
    );
  }
}
