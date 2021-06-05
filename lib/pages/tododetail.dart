import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metriccalculator/utils/model/metric.dart';
import 'package:metriccalculator/utils/repo/metric-dbconnections.dart';
import 'package:flutter/services.dart';

MetricDbHelper helper = MetricDbHelper();

class TodoDetail extends StatefulWidget {
  final List<Metric> metricList;
  bool isEdit;
  TodoDetail(this.metricList, this.isEdit);

  @override
  State<StatefulWidget> createState() => TodoDetailState(metricList, isEdit);
}

class TodoDetailState extends State<TodoDetail> {
  List<Metric> metricList;
  bool isEditt;

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
                      Text("ocak"),
                      TextFormField(
                          maxLength: 30,
                          onSaved: (value) {
                            metricList[0].setTarget = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'null_title';
                            }

                            if (value.length > 30) {
                              return 'limit_title';
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: metricList[0].target.toString(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      Text("şubat"),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[1].setTarget = value;
                          },
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
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[2].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[3].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[4].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[5].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[6].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[7].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[8].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[9].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[10].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            labelStyle: textStyle,
                          )),
                      TextFormField(
                          maxLength: 50,
                          onSaved: (value) {
                            metricList[11].setTarget = value;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'şubat ayı',
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
                          //    helper.deleteTodo(todo.id);
                          //buraya delete gelecek
                          Navigator.of(context).pop();
                          Navigator.pop(context, true);
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
                debugPrint("Click Floated Back.");
                //confirmDelete();
                //confirm delete
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

/*
  void save() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      todo.date = new DateFormat.yMd().format(DateTime.now());
      if (todo.id != null) {
        helper.updateTodo(todo);
      } else {
        helper.insertTodo(todo);
      }
      Navigator.pop(context, true);
    }
  }
  void updatePriority(String value) {
    switch (value) {
      case 'High':
        todo.priority = 1;
        break;
      case 'Medium':
        todo.priority = 2;
        break;
      case 'Low':
        todo.priority = 3;
        break;
    }
    setState(() {
      _priority = value;
    });
  }
  void updateIsDone(String value) {
    switch (value) {
      case 'false':
        todo.isDone = 1;
        break;
      case 'true':
        todo.isDone = 2;
        break;
    }
    setState(() {
      _isdone = value;
    });
  }
  String retrievePriority(int value) {
    return _priorities[value - 1];
  }
  String retrieveIsDone(int value) {
    return _isdones[value - 1];
  }
  void updateTitle() {
    setState(() {
      todo.title = titleController.text;
    });
  }
  void updateDescription() {
    setState(() {
      todo.description = descriptionController.text;
    });
  }*/
  void confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('sure_delate', style: TextStyle(fontSize: 15.0)),
        actions: <Widget>[
          new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()),
          new FlatButton(
              child: new Text(
                'DELETE',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                //    helper.deleteTodo(todo.id);
                //buraya delete gelecek
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              })
        ],
      ),
    );
  }
}
