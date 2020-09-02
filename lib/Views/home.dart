import 'package:attandace_app/Model/subject_model.dart';
import 'package:attandace_app/Views/add_new.dart';
import 'package:attandace_app/Views/top_section.dart';
import 'package:attandace_app/Views/utils/constants.dart';

import 'package:attandace_app/helper/provider_subject.dart';
import 'package:attandace_app/helper/remarks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/database_helper.dart';
import '../Model/subject_model.dart';
import 'card/subject_card.dart';
import 'utils/check_day.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  ScrollController _scrollController;
  double _val = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      setState(() {
        _val = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          AnimatedPositioned(
            top: size.height * 0.3 - _val,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.bounceInOut,
              height: size.height * 0.7 + _val,
              width: size.width,
              color: bg,
              child: Consumer<SubjectData>(
                builder: (context, sub_data, child) {
                  List _all_class_data = sub_data.all_subject_data;

                  return _all_class_data != null
                      ? ListView.builder(
                          controller: _scrollController,
                          // physics: BouncingScrollPhysics(),
                          itemCount: _all_class_data.length,
                          itemBuilder: (context, index) {
                            int _id = _all_class_data[index]['_id'];
                            int _goal = _all_class_data[index]['goal'];
                            int _total = _all_class_data[index]['total'];
                            int _present = _all_class_data[index]['present'];
                            String _name = _all_class_data[index]['name'];
                            List<String> _routine = _all_class_data[index]
                                        ['routine'] !=
                                    null
                                ? _all_class_data[index]['routine'].split(",")
                                : [];
                            List<String> _histories = _all_class_data[index]
                                        ['histories'] !=
                                    null
                                ? _all_class_data[index]['histories'].split(",")
                                : [];

                            SubjectModel _sub = SubjectModel(
                                id: _id,
                                total: _total,
                                present: _present,
                                name: _name,
                                routine: _routine,
                                goal: _goal,
                                histories: _histories);
                            bool isToday = false;

                            String today = check_date();

                            _sub.routine.forEach((element) {
                              element = element.replaceAll(" ", "");
                              if (element == today) {
                                isToday = true;
                              }
                            });

                            double percentage = _sub.total != 0
                                ? _sub.present / _sub.total * 100
                                : 0;

                            Container cont = Container(
                              decoration: card_decor.copyWith(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 10,
                              width: 10,
                            );
                            List<Container> last_5_classes = [];

                            List<String> history = [];
                            try {
                              _sub.histories.forEach((element) {
                                history.add(element[0]);
                              });
                            } catch (e) {
                              print("History $e");
                            }
                            var len = history.length;
                            var last_5 = history.sublist(len - 5, len);
                            last_5.forEach((element) {
                              Color _color;
                              if (element == 'Y') {
                                _color = percentage_color;
                              } else if (element == 'N') {
                                _color = Colors.redAccent;
                              } else {
                                _color = bg;
                              }
                              last_5_classes.add(Container(
                                decoration: card_decor.copyWith(
                                    color: _color,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 7,
                                width: 7,
                              ));
                            });
                            // print(history.sublist(len - 5, len));

                            // ADD Goal stats to database
                            double goal = _sub.goal.toDouble();
                            String remarks =
                                Remarks(goal, _sub.total, _sub.present);

                            return Subject_card(
                                size: size,
                                isToday: isToday,
                                percentage: percentage,
                                sub: _sub,
                                remarks: remarks,
                                last_5_classes: last_5_classes);
                          })
                      : Container();
                },
              ),
            ),
          ),
          AnimatedPositioned(
              curve: Curves.linear,
              top: 0 - _val * 0.7,
              child: Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                    color: Color(0xff3e4b65),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black, spreadRadius: 3, blurRadius: 6)
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: TopSec(),
              ),
              duration: Duration(milliseconds: 200)),
        ],
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'ECE 4109',
      DatabaseHelper.columnHistories: 'X,X,X,X,X',
      DatabaseHelper.columnTotal: 0,
      DatabaseHelper.columnRoutine: "sun,fri,Tuesday",
      // DatabaseHelper.columnHistories:
      //     "N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995,N1598117377995",
      DatabaseHelper.columnPresent: 0,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
}
