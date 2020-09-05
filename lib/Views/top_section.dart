import 'package:attandace_app/Views/add_new.dart';
import 'package:attandace_app/Views/routine.dart';
import 'package:attandace_app/Views/settings/settings.dart';
import 'package:attandace_app/Views/stats.dart';
import 'package:attandace_app/Views/utils/constants.dart';
import 'package:attandace_app/helper/provider_subject.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopSec extends StatefulWidget {
  @override
  _TopSecState createState() => _TopSecState();
}

class _TopSecState extends State<TopSec> {
  double _default_goal = 60;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SubjectData>(context, listen: false).Get_from_database();
    getInt();
  }

  getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = await prefs.getInt('goal');
    setState(() {
      _default_goal = intValue != null ? intValue.toDouble() : 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Attandance Assistant',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.yellow,
                        letterSpacing: 2.0,
                        fontSize: kfont_mid),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.trophy,
                          color: total_color,
                          size: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              ' Primary Goal : ',
                              style:
                                  TextStyle(fontSize: kfont_small, color: bg),
                            ),
                            Text(
                              '${_default_goal.toStringAsFixed(0)}%',
                              style: TextStyle(
                                  fontSize: kfont_large,
                                  fontWeight: FontWeight.bold,
                                  color: bg),
                            )
                          ],
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/profile.png')),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: button_decor,
                            child: FaIcon(
                              FontAwesomeIcons.slidersH,
                              color: title_color,
                              size: 20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stats()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: button_decor,
                            child: FaIcon(
                              FontAwesomeIcons.chartBar,
                              color: title_color,
                              size: 20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Routine()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: button_decor,
                            child: FaIcon(
                              FontAwesomeIcons.calendarAlt,
                              color: title_color,
                              size: 20,
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(5),
                        //   decoration: button_decor,
                        //   child: FaIcon(
                        //     FontAwesomeIcons.infoCircle,
                        //     color: title_color,
                        //     size: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.6,
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Consumer<SubjectData>(builder: (context, sub_data, child) {
                    int present = 0;
                    int total = 0;
                    List subject_data = sub_data.all_subject_data;
                    subject_data.forEach((element) {
                      present = present + element['present'];
                      total = total + element['total'];
                    });

                    print(present);
                    print(total);

                    double percentage = total != 0 ? present / total : 0;
                    return Percent(
                      percent: percentage,
                    );
                  }),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Add_sub()));
                    },
                    child: Container(
                      width: 80,
                      height: 35,
                      decoration: button_decor.copyWith(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.plus,
                            size: 10,
                          ),
                          Text('ADD')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Percent extends StatefulWidget {
  Percent({@required this.percent});
  final percent;
  @override
  _PercentState createState() => _PercentState();
}

class _PercentState extends State<Percent> {
  @override
  Widget build(BuildContext context) {
    double _progress = widget.percent;
    return Center(
      child: Container(
        height: 75,
        width: 75,
        child: CustomPaint(
          painter: GradientArcPainter(
            progress: _progress,
            startColor: total_color,
            endColor: title_color,
            width: 12.0,
          ),
          child: Center(
              child: Text(
            '${(_progress * 100).toStringAsFixed(0)}%',
            style:
                TextStyle(color: bg, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}

class GradientArcPainter extends CustomPainter {
  const GradientArcPainter({
    @required this.progress,
    @required this.startColor,
    @required this.endColor,
    @required this.width,
  })  : assert(progress != null),
        assert(startColor != null),
        assert(endColor != null),
        assert(width != null),
        super();

  final double progress;
  final Color startColor;
  final Color endColor;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Path path = Path();
    final gradient = new SweepGradient(
      startAngle: -4 * pi / 3,
      endAngle: pi / 2,
      tileMode: TileMode.repeated,
      colors: [startColor, endColor],
    );

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final paint2 = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -4 * pi / 3;
    final sweepAngle = 5 / 3 * pi * progress;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, 5 / 3 * pi, false, paint2);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
