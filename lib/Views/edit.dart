import 'package:attandace_app/Model/subject_model.dart';
import 'package:attandace_app/Views/home.dart';
import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  Edit({
    @required SubjectModel sub,
  }) : _sub = sub;
  final SubjectModel _sub;
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
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
  String present_string;
  String total_string;
  int _goal;
  List<bool> _routine;

  bool detect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _goal = widget._sub.goal;
      print(_goal);
      print(widget._sub.routine.runtimeType);

      widget._sub.routine.forEach((element) {
        print(element);
        if (element == 'Saturday') {
          isSat = true;
        } else if (element == 'Sunday') {
          isSun = true;
        } else if (element == 'Monday') {
          isMon = true;
        } else if (element == 'Tuesday') {
          isTue = true;
        } else if (element == 'Wednesday') {
          isWed = true;
        } else if (element == 'Thursday') {
          isThu = true;
        } else if (element == 'Friday') {
          isFri = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int _new_goal;

    List<String> routine = widget._sub.routine;

    _routine = [isSat, isSun, isMon, isTue, isWed, isThu, isFri];
    print(_routine);
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
    void _delete(id) async {
      final rowsDeleted = await dbHelper.delete(id);
      print('deleted $rowsDeleted row(s): row $id');
      Provider.of<SubjectData>(context, listen: false).Get_from_database();
    }

    void _showDialog(message) {
      // flutter defined function
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            elevation: 16.0,
            title: new Text(message),
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

    void _showDialog_delete(id) {
      // flutter defined function
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            elevation: 16.0,
            title: new Text("Do you really want to delete permanently?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  _delete(id);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
            ],
          );
        },
      );
    }

    void _update(row) async {
      final rowsAffected = await dbHelper.update(row);
      print('updated $rowsAffected row(s)');
      Provider.of<SubjectData>(context, listen: false).Get_from_database();
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffdfe4eb),
        body: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            child: Container(
              decoration: card_decor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Update the details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: kfont_large),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Title',
                            style: TextStyle(fontSize: kfont_mid),
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
                              hintText: widget._sub.name,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.15,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Present',
                                        style: TextStyle(fontSize: kfont_mid)),
                                    SizedBox(
                                      width: size.height * 0.03,
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
                                        hintText:
                                            widget._sub.present.toString(),
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
                                    Text('Total',
                                        style: TextStyle(fontSize: kfont_mid)),
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
                                        hintText: widget._sub.total.toString(),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('New Goal'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: title_color,
                                        shape: BoxShape.circle),
                                    child: Text(_goal.toStringAsFixed(0),
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
                                  value: _goal.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      _goal = value.ceil();
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
                                child: Text('Tap to Select Routine')),
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: size.height * 0.1,
                            width: size.width * 0.8,
                            child: FittedBox(
                              child: Column(
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
                                      SizedBox(
                                        width: 15,
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
                                      SizedBox(
                                        width: 15,
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
                                      SizedBox(
                                        width: 15,
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
                                      SizedBox(
                                        width: 15,
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
                                      SizedBox(
                                        width: 15,
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
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: InkWell(
                                  onTap: () {
                                    if (total_string == '' ||
                                        total_string == null) {
                                      total_string =
                                          widget._sub.total.toString();
                                    }
                                    print(total_string);
                                    if (present_string == '' ||
                                        present_string == null) {
                                      present_string =
                                          widget._sub.present.toString();
                                    }

                                    String title = _title_string;

                                    if (title == null) {
                                      title = widget._sub.name;
                                    }
                                    int total = int.parse(total_string);
                                    int present = int.parse(present_string);
                                    int goal = _goal;
                                    String routine = final_routine
                                        .toString()
                                        .replaceAll(" ", "")
                                        .replaceAll('[', '')
                                        .replaceAll(']', '');
                                    widget._sub.name = title;
                                    widget._sub.present = present;
                                    widget._sub.total = total;
                                    widget._sub.routine = final_routine;
                                    widget._sub.goal = goal;
                                    print('routine');
                                    print(final_routine);

                                    _update(widget._sub.toMap_update());
                                    _showDialog('Subject updated successfully');
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: card_decor.copyWith(
                                          color: title_color),
                                      child: Center(
                                          child: Text(
                                        'Update Subject',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ))))),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: InkWell(
                                  onTap: () {
                                    _showDialog_delete(widget._sub.id);
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: card_decor.copyWith(
                                          color: Colors.redAccent),
                                      child: Center(
                                          child: Text(
                                        'Delete Subject',
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
}

// class CurrentName extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(Text('Current Name:'));
//   }
// }
