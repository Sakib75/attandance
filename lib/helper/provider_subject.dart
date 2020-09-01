import 'package:attandace_app/helper/database_helper.dart';
import 'package:flutter/cupertino.dart';

class SubjectData extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> all_subject_data;

  void Get_from_database() async {
    final dbHelper = DatabaseHelper.instance;
    all_subject_data = await dbHelper.queryAllRows();

    notifyListeners();
  }
}
