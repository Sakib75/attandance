import 'package:attandace_app/Views/home.dart';
import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_sub extends StatefulWidget {
  @override
  _Add_subState createState() => _Add_subState();
}

class _Add_subState extends State<Add_sub> {
  final dbHelper = DatabaseHelper.instance;

  double rating = 0;
  int goal = 0;
  bool isSun = false;
  bool isMon = false;
  bool isTue = false;
  bool isWed = false;
  bool isThu = false;
  bool isFri = false;
  bool isSat = false;
  TextEditingController _title;
  TextEditingController _present;
  TextEditingController _total;
  String _title_string;
  String present_string = '0';
  String total_string = '0';
  Color add_btn = Colors.black12;
  int _goal;

  bool detect = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInt();
    print(' goal : $_goal');
  }

  getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = await prefs.getInt('goal');
    setState(() {
      goal = intValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_title_string == '' || _title_string == null) {
      setState(() {
        add_btn = Colors.black12;
      });
    } else {
      setState(() {
        add_btn = title_color;
      });
    }
    List<bool> _routine = [isSat, isSun, isMon, isTue, isWed, isThu, isFri];
    List<String> final_routine = [];
    if (_routine[0]) {
      final_routine.add('Saturday');
    }
    if (_routine[1]) {
      final_routine.add('Sunday');
    }
    if (_routine[2]) {
      final_routine.add('Monday');
    }
    if (_routine[3]) {
      final_routine.add('Tuesday');
    }
    if (_routine[4]) {
      final_routine.add('Wednesday');
    }
    if (_routine[5]) {
      final_routine.add('Thursday');
    }
    if (_routine[6]) {
      final_routine.add('Friday');
    }
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffdfe4eb),
        body: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              decoration: card_decor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter the details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: kfont_large),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(fontSize: kfont_mid),
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _title_string = val;
                              });
                            },
                            style: TextStyle(fontSize: kfont_mid),
                            maxLength: 15,
                            controller: _title,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Goal',
                                    style: TextStyle(fontSize: kfont_mid),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: title_color,
                                        shape: BoxShape.circle),
                                    child: Text(goal.toStringAsFixed(0),
                                        style: TextStyle(
                                          fontSize: kfont_mid,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: title_color,
                                  inactiveTrackColor: total_color,
                                  trackShape: RectangularSliderTrackShape(),
                                  trackHeight: 4.0,
                                  thumbColor: title_color,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 100,
                                  value: goal.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      goal = value.ceil();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Center(
                              child: GestureDetector(
                            onTapDown: (val) {
                              setState(() {
                                detect = false;
                              });
                            },
                            onTapUp: (val) {
                              setState(() {
                                detect = true;
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Tap to Select Routine',
                                  style: TextStyle(fontSize: kfont_mid),
                                )),
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSat = isSat ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isSat
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Sat',
                                          style: TextStyle(
                                              color: isSat
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSun = isSun ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isSun
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Sun',
                                          style: TextStyle(
                                              color: isSun
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isMon = isMon ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isMon
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Mon',
                                          style: TextStyle(
                                              color: isMon
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isTue = isTue ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isTue
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Tue',
                                          style: TextStyle(
                                              color: isTue
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isWed = isWed ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isWed
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Wed',
                                          style: TextStyle(
                                              color: isWed
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isThu = isThu ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isThu
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Thu',
                                          style: TextStyle(
                                              color: isThu
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFri = isFri ? false : true;
                                      });
                                    },
                                    child: Container(
                                        decoration: isFri
                                            ? card_decor.copyWith(
                                                color: title_color)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Fri',
                                          style: TextStyle(
                                              color: isFri
                                                  ? Colors.white
                                                  : title_color),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          add_btn == Colors.black12
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    'Please enter the title',
                                    style: TextStyle(color: Colors.red),
                                  )),
                                )
                              : Text(''),
                          Center(
                              child: AbsorbPointer(
                            absorbing: add_btn == Colors.black12 ? true : false,
                            child: InkWell(
                                onTap: () {
                                  if (total_string == '') {
                                    total_string = '0';
                                  }

                                  if (present_string == '') {
                                    present_string = '0';
                                  }

                                  String title = _title_string;
                                  int total = int.parse(total_string);
                                  int present = int.parse(present_string);

                                  String routine = final_routine
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '');
                                  print(total.runtimeType);
                                  print(present.runtimeType);
                                  print(routine.runtimeType);
                                  print(title.runtimeType);
                                  _insert(title, present, total, routine, goal);
                                  _showDialog();
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration:
                                        card_decor.copyWith(color: add_btn),
                                    child: Center(
                                        child: Text(
                                      'Add Subject',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )))),
                          ))
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          elevation: 16.0,
          title: new Text("New Subject added"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Return to homepage"),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ],
        );
      },
    );
  }

  void _insert(title, present, total, routine, goal) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnHistories: 'X,X,X,X,X',
      DatabaseHelper.columnTotal: total,
      DatabaseHelper.columnRoutine: routine,
      DatabaseHelper.columnGoal: goal,
      // DatabaseHelper.columnHistories:
      //     "N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995",
      DatabaseHelper.columnPresent: present,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
  }
}
