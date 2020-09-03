import 'dart:math';

import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> with SingleTickerProviderStateMixin {
  final dbHelper = DatabaseHelper.instance;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.forward();
    _animationController.addListener(() {
      print(_animationController.value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        body: Consumer<SubjectData>(
          builder: (context, sub_data, child) {
            List<String> all_presents = [];
            List<String> all_presents_weekday = [];
            List<String> all_absents = [];
            List<String> all_absents_weekday = [];
            List subject_data = sub_data.all_subject_data;
            subject_data.forEach((sub) {
              List _histories = sub['histories'].split(',');
              var format = new DateFormat("EEEE");
              _histories.forEach((element) {
                String history = element;
                if (history.startsWith("Y")) {
                  all_presents.add(history);

                  //
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(element.replaceAll("Y", "")));

                  var dateString = format.format(date);

                  all_presents_weekday.add(dateString);
                } else if (history.startsWith("N")) {
                  all_absents.add(history);

                  //
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(element.replaceAll("N", "")));

                  var dateString = format.format(date);

                  all_absents_weekday.add(dateString);
                }
              });
            });

            //Total count
            int total_presents = all_presents.length;
            int total_absents = all_absents.length;
            int total_classes = total_absents + total_presents;

            var all_presents_map = {
              'Saturday': 0,
              'Sunday': 0,
              'Monday': 0,
              'Tuesday': 0,
              'Wednesday': 0,
              'Thursday': 0,
              'Friday': 0
            };

            all_presents_weekday.forEach((element) {
              if (!all_presents_map.containsKey(element)) {
                all_presents_map[element] = 1;
              } else {
                all_presents_map[element] += 1;
              }
            });

            var all_absents_map = {
              'Saturday': 0,
              'Sunday': 0,
              'Monday': 0,
              'Tuesday': 0,
              'Wednesday': 0,
              'Thursday': 0,
              'Friday': 0
            };

            all_absents_weekday.forEach((element) {
              if (!all_absents_map.containsKey(element)) {
                all_absents_map[element] = 1;
              } else {
                all_absents_map[element] += 1;
              }
            });

            // var sortedEntries = all_presents_map.entries.toList()
            //   ..sort((e1, e2) {
            //     var diff = e2.value.compareTo(e1.value);
            //     if (diff == 0) diff = e2.key.compareTo(e1.key);
            //     return diff;
            //   });

            Size size = MediaQuery.of(context).size;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundCard(
                      round: 120,
                      title: 'Total Class',
                      animationController: _animationController,
                      total_classes: total_classes),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundCard(
                          round: 80,
                          title: 'Present',
                          animationController: _animationController,
                          total_classes: all_presents.length),
                      RoundCard(
                          round: 80,
                          title: 'Absent',
                          animationController: _animationController,
                          total_classes: all_absents.length),
                    ],
                  ),

                  Container(
                      margin: EdgeInsets.all(15),
                      decoration: card_decor,
                      height: size.height * 0.5,
                      child: ChartsDemo(
                        present: all_presents_map,
                        absent: all_absents_map,
                      ))

                  // Chart for weekday

                  //Combine Calculation
                ],
              ),
            );
          },
        ));
  }
}

class RoundCard extends StatelessWidget {
  const RoundCard({
    Key key,
    @required AnimationController animationController,
    @required this.title,
    @required this.round,
    @required this.total_classes,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final int total_classes;
  final String title;
  final double round;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: round,
          width: round,
          decoration: card_decor.copyWith(
              color: title_color, borderRadius: BorderRadius.circular(100)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                total_classes.toString(),
                style: TextStyle(color: Colors.yellow, fontSize: 30),
              ),
              Text(
                '$title',
                style: TextStyle(color: Colors.white),
              )
            ],
          ))),
    );
  }
}

class ChartsDemo extends StatefulWidget {
  ChartsDemo({@required this.present, @required this.absent});
  Map present;
  Map absent;

  final String title = "Charts Demo";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;

  static List<charts.Series<Weekday, String>> _createRandomData(
      present, absent) {
    final desktopSalesData = [
      Weekday('Sat', present['Saturday']),
      Weekday('Sun', present['Sunday']),
      Weekday('Mon', present['Monday']),
      Weekday('Tue', present['Tuesday']),
      Weekday('Wed', present['Wednesday']),
      Weekday('Thu', present['Thursday']),
      Weekday('Fri', present['Friday']),
      // Weekday('2015', 10),
      // Weekday('2016', 20),
      // Weekday('2017', 30),
      // Weekday('2018', 40),
      // Weekday('2019', 50),
      // Weekday('2019', 60),
      // Weekday('2019', 80),
    ];

    final tabletSalesData = [
      Weekday('Sat', absent['Saturday']),
      Weekday('Sun', absent['Sunday']),
      Weekday('Mon', absent['Monday']),
      Weekday('Tue', absent['Tuesday']),
      Weekday('Wed', absent['Wednesday']),
      Weekday('Thu', absent['Thursday']),
      Weekday('Fri', absent['Friday']),
    ];

    // final mobileSalesData = [
    //   Sales('2015', random.nextInt(100)),
    //   Sales('2016', random.nextInt(100)),
    //   Sales('2017', random.nextInt(100)),
    //   Sales('2018', random.nextInt(100)),
    //   Sales('2019', random.nextInt(100)),
    // ];

    return [
      charts.Series<Weekday, String>(
        id: 'Sales',
        domainFn: (Weekday data, _) => data.name,
        measureFn: (Weekday data, _) => data.absent,
        data: desktopSalesData,
        fillColorFn: (Weekday sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<Weekday, String>(
        id: 'Sales',
        domainFn: (Weekday data, _) => data.name,
        measureFn: (Weekday data, _) => data.absent,
        data: tabletSalesData,
        fillColorFn: (Weekday sales, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
      ),
    ];
  }

  barChart(present, absent) {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 0.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData(widget.present, widget.absent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(widget.present, widget.absent),
      ),
    );
  }
}

class Weekday {
  final String name;
  final int absent;

  Weekday(this.name, this.absent);
}
