import 'package:attandace_app/Views/percentage_bar.dart';
import 'package:attandace_app/Views/settings/settings.dart';
import 'package:attandace_app/Views/stats.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Views/home.dart';
import 'Views/percentage_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubjectData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        // home: ChartsDemo(),
      ),
    );
  }
}
