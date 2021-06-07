import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metriccalculator/pages/calories_section/calories.dart';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:metriccalculator/utils/repo/metric-dbconnections.dart';
import 'package:flutter/services.dart';
import 'package:metriccalculator/utils/service/metricService.dart';

MetricDbHelper helper = MetricDbHelper();

class TodoDetail extends StatefulWidget {
  final List<Metric> metricList;
  bool isEdit;
  TodoDetail(this.metricList, this.isEdit);

  @override
  State<StatefulWidget> createState() => TodoDetailState(metricList, isEdit);
}

class TodoDetailState extends State<TodoDetail> {
  final globalKey = GlobalKey<ScaffoldState>();
  List<Metric> metricList;
  bool isEditt;
  MetricService metricService = new MetricService();

  TextEditingController titleController = TextEditingController();
  bool isEdit;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    isEdit = isEditt == false ? false : true;
    titleController.text = metricList[0].target.toString();
  }

  TodoDetailState(this.metricList, this.isEdit);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigoAccent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 00.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Text(
              metricList[0].metricName,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15.0,
                      spreadRadius: -5.0,
                      offset: Offset(0.0, 7.0)),
                ],
              ),
              width: 320.0,
              height: 440.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Text("Ocak"),
                      TextFormField(
                          maxLength: 30,
                          onSaved: (value) {
                            metricList[0].target = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[0].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                            initialValue:
                            metricList[0].target;
                          },
                          initialValue: metricList[0].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[0].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Şubat"),
                      TextFormField(
                          maxLength: 20,
                          onSaved: (value) {
                            metricList[1].target = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[1].target.toString();
                            }
                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[1].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[1].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Mart"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[2].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[2].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[2].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[2].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Nisan"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[3].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[3].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[3].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[3].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Mayıs"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[4].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[4].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[4].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[4].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Haziran"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[5].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[5].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[5].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[5].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Temmuz"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[6].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[6].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[6].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[6].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Ağustos"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[7].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[7].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[7].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[7].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("Eylül"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[8].setTarget = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return metricList[8].target.toString();
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          initialValue: metricList[8].target.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[8].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.all(13.0),
                        elevation: 2.0,
                        textColor: Colors.white,
                        color: Colors.amber,
                        //onPressed: () => save(),
                        onPressed: () {
                          update(metricList);
                          Navigator.of(context);
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          isEdit ? "Edit" : "Add",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isEdit
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context);
                Navigator.pop(context, false);
                // debugPrint("Click Floated Back.");
                //confirmDelete();
              },
              elevation: 5.0,
              backgroundColor: Colors.red,
              tooltip: 'cancel',
              child: new Icon(
                Icons.clear,
                size: 35.0,
              ))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  final snackBar = SnackBar(
    content: Text("Bu Benim İlk Mesajım."),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      textColor: Colors.white,
      label: "Test Butonu",
      onPressed: () {
        // Buraya Butona Tıklayınca Yapılacak Olaylar Yazılacak.
      },
    ),
  );

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 100),
    ));
  }

  void updateTarget(int value, int i) {
    setState(() {
      metricList[i].target = value;
    });
  }

  void update(List<Metric> metricList) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      for (int i = 0; i < metricList.length; i++) {
        metricService.updateMetric(metricList[i]);
        print("update etti");
      }
    }
    metricService.setAllMetricByActual();
  }
}
