import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Routine extends StatefulWidget {
  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SubjectData>(builder: (context, sub_data, child) {
        List subject_data = sub_data.all_subject_data;
        print(subject_data);
        var routine = {
          'Saturday': [],
          'Sunday': [],
          'Monday': [],
          'Tuesday': [],
          'Wednesday': [],
          'Thursday': [],
          'Friday': []
        };

        subject_data.forEach((element) {
          if (element['routine'] != null || element['routine'] != '') {
            var title = element['name'];
            List days = element['routine'].split(',');
            days.forEach((day) {
              day = day.replaceAll(' ', '');
              print(routine[day]);
              if (routine[day] != null) {
                routine[day].add(title);
              }
            });
          }
        });
        print(routine);
        Size size = MediaQuery.of(context).size;
        List<Container> _routine_container = [];
        routine.forEach((key, value) {
          _routine_container.add(
            Container(
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${key.substring(0, 3)}',
                          style: TextStyle(
                              color: title_color,
                              fontWeight: FontWeight.bold,
                              fontSize: kfont_large),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total  ',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              '${routine[key].length.toString()}',
                              style: TextStyle(
                                  fontSize: kfont_mid,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Classes',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 0.15,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: size.height * 0.15,
                              padding: const EdgeInsets.all(8.0),
                              decoration: card_decor.copyWith(
                                  color: title_color,
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [
                                        1.0,
                                        1.0
                                      ],
                                      colors: [
                                        title_color,
                                        Colors.transparent
                                      ])),
                              child: Center(
                                  child: Text(
                                routine[key][index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ))),
                        ));
                      },
                      itemCount: routine[key].length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });

        return Container(
          color: bg,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: FaIcon(FontAwesomeIcons.arrowLeft)),
                        Row(
                          children: [
                            Text(
                              'Weekly',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Routine',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _routine_container,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
