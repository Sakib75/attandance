import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Add_sub extends StatefulWidget {
  @override
  _Add_subState createState() => _Add_subState();
}

class _Add_subState extends State<Add_sub> {
  final dbHelper = DatabaseHelper.instance;

  double rating = 0;
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

  bool detect = false;
  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(fontSize: 10),
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _title_string = val;
                              });
                            },
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
                          Container(
                            width: 500,
                            height: 100,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Initial present',
                                        style: TextStyle(fontSize: 10)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      onChanged: (val) {
                                        setState(() {
                                          present_string = val;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    )),
                                    Text('Initial Total',
                                        style: TextStyle(fontSize: 10)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      onChanged: (val) {
                                        setState(() {
                                          total_string = val;
                                        });
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
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
                                child: Text('Tap to Select Routine')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Sat')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Sun')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Mon')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Tue')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Thu')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Wed')),
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
                                                color: Colors.green)
                                            : card_decor,
                                        padding: EdgeInsets.all(5),
                                        child: Text('Fri')),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: InkWell(
                                  onTap: () {
                                    if (total_string == '') {
                                      total_string = '0';
                                    }
                                    print(total_string);
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
                                    _insert(title, present, total, routine);
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: card_decor.copyWith(
                                          color: Colors.black12),
                                      child: Center(
                                          child: Text(
                                        'Add Subject',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )))))
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  void _insert(title, present, total, routine) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnHistories: 'X,X,X,X,X',
      DatabaseHelper.columnTotal: total,
      DatabaseHelper.columnRoutine: routine,
      // DatabaseHelper.columnHistories:
      //     "N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995",
      DatabaseHelper.columnPresent: present,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
  }
}
