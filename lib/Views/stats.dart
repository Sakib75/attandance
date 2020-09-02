import 'package:attandace_app/helper/database_helper.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
  }

  @override
  Widget build(BuildContext context) {
    List<String> all_presents = [];
    List<String> all_presents_weekday = [];
    List<String> all_absents = [];
    List<String> all_absents_weekday = [];
    return Scaffold(body: Consumer<SubjectData>(
      builder: (context, sub_data, child) {
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

        var all_presents_map = Map();

        all_presents_weekday.forEach((element) {
          if (!all_presents_map.containsKey(element)) {
            all_presents_map[element] = 1;
          } else {
            all_presents_map[element] += 1;
          }
        });

        print(all_presents_map);

        var all_absents_map = Map();

        all_absents_weekday.forEach((element) {
          if (!all_absents_map.containsKey(element)) {
            all_absents_map[element] = 1;
          } else {
            all_absents_map[element] += 1;
          }
        });

        print(all_absents_map);

        var sortedEntries = all_presents_map.entries.toList()
          ..sort((e1, e2) {
            var diff = e2.value.compareTo(e1.value);
            if (diff == 0) diff = e2.key.compareTo(e1.key);
            return diff;
          });

        print(sortedEntries);
        return Center(
          child: Column(
            children: [
              Text(total_classes.toString()),
              Text(all_presents.length.toString()),
              Text(all_absents.length.toString()),
            ],
          ),
        );
      },
    ));
  }
}
