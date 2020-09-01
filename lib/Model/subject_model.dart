import 'package:sqflite/sqflite.dart';

import '../helper/database_helper.dart';

class SubjectModel {
  int id;
  String name;
  int total;
  int present;
  List<String> histories;
  List<String> routine;

  SubjectModel(
      {this.id,
      this.name,
      this.present,
      this.total,
      this.histories,
      this.routine});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: this.name,
      DatabaseHelper.columnPresent: this.present,
      DatabaseHelper.columnTotal: this.total,
      DatabaseHelper.columnHistories: this.histories.toString(),
      DatabaseHelper.columnRoutine: this.routine.toString()
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
    };
  }
}
