import 'package:sqflite/sqflite.dart';

import '../helper/database_helper.dart';

class SubjectModel {
  int id;
  String name;
  int total;
  int present;
  List<String> histories;
  List<String> routine;
  int goal;

  SubjectModel(
      {this.id,
      this.name,
      this.present,
      this.total,
      this.histories,
      this.routine,
      this.goal});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: this.name,
      DatabaseHelper.columnPresent: this.present,
      DatabaseHelper.columnTotal: this.total,
      DatabaseHelper.columnHistories: this.histories.toString(),
      DatabaseHelper.columnRoutine: this.routine.toString(),
      DatabaseHelper.columnGoal: this.goal,
    };
  }

  Map<String, dynamic> toMap_update() {
    return {
      DatabaseHelper.columnId: this.id,
      DatabaseHelper.columnName: this.name,
      DatabaseHelper.columnPresent: this.present,
      DatabaseHelper.columnTotal: this.total,
      DatabaseHelper.columnHistories: this
          .histories
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', ''),
      DatabaseHelper.columnRoutine: this
          .routine
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', ''),
      DatabaseHelper.columnGoal: this.goal,
    };
  }
}
