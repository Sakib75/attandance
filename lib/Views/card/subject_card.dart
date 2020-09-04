import 'package:attandace_app/Views/edit.dart';
import 'package:flutter/material.dart';
import '../../Model/subject_model.dart';
import '../../helper/database_helper.dart';
import 'package:provider/provider.dart';
import '../../helper/provider_subject.dart';
import '../utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../helper/add_history.dart';

// ignore: camel_case_types
class Subject_card extends StatelessWidget {
  const Subject_card({
    Key key,
    @required this.size,
    @required this.isToday,
    @required this.percentage,
    @required SubjectModel sub,
    @required this.remarks,
    // ignore: non_constant_identifier_names
    @required this.last_5_classes,
  })  : _sub = sub,
        super(key: key);

  final Size size;
  final bool isToday;
  final double percentage;
  final SubjectModel _sub;
  final String remarks;
  // ignore: non_constant_identifier_names
  final List<Container> last_5_classes;

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;
    bool status = false;
    int goal = _sub.goal;
    print("goal");
    print(goal);

    // void _query() async {
    //   final allRows = await dbHelper.queryAllRows();
    //   print('query all rows:');
    //   allRows.forEach((row) => print(row));
    // }

    void _update(row) async {
      final rowsAffected = await dbHelper.update(row);
      print('updated $rowsAffected row(s)');
      Provider.of<SubjectData>(context, listen: false).Get_from_database();
    }

    // void _delete(row) async {
    //   final id = row.id;
    //   final rowsDeleted = await dbHelper.delete(id);
    //   print('deleted $rowsDeleted row(s): row $id');
    //   Provider.of<SubjectData>(context, listen: false).Get_from_database();
    // }

    // Check status

    // ignore: non_constant_identifier_names
    check_status() {
      if (percentage >= goal) {
        status = true;
      } else {
        status = false;
      }
    }

    check_status();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: card_decor,
      // height: size.height * 0.15,
      width: size.width,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isToday == true
                  ? Text(
                      'Today!',
                      style: TextStyle(
                          color: Color(0xff7DA93E), fontSize: kfont_mid),
                    )
                  : Text(''),
              Container(
                height: 40,
                width: 70,
                decoration: card_decor.copyWith(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: status
                            ? [Colors.green, Color(0xff28C76F)]
                            : [Color(0xffFFAA85), Color(0xffB3315F)]),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: FittedBox(
                  child: Text("${percentage.toStringAsFixed(2)}%",
                      style: TextStyle(
                          fontSize: kfont_mid + 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 120,
                    child: Text(
                      _sub.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: title_color,
                          fontSize: kfont_mid),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${_sub.present.toString()}/',
                    style: TextStyle(fontSize: 20, color: present_color),
                  ),
                  Text(
                    _sub.total.toString(),
                    style: TextStyle(fontSize: 24, color: total_color),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.infoCircle,
                      color: Color(0xff677a91),
                      size: 10,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(remarks,
                        style: TextStyle(fontSize: 10, color: title_color)),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // _delete(_sub);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(
                                  sub: _sub,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: card_decor,
                    child: FaIcon(
                      FontAwesomeIcons.pencilAlt,
                      color: edit_color,
                      size: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _sub.present += 1;
                          _sub.total += 1;
                          _sub.histories.add(history(true));

                          _update(_sub.toMap_update());
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: card_decor,
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.thumbsUp,
                              color: thumbsup_color,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _sub.total += 1;
                          _sub.histories.add(history(false));

                          _update(_sub.toMap_update());
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: card_decor,
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.thumbsDown,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: last_5_classes,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
