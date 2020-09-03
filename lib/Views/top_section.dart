import 'package:attandace_app/Views/add_new.dart';
import 'package:attandace_app/Views/routine.dart';
import 'package:attandace_app/Views/settings/settings.dart';
import 'package:attandace_app/Views/stats.dart';
import 'package:attandace_app/Views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopSec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Lazy Attandance Manager',
                    style: TextStyle(color: Colors.white60, letterSpacing: 2.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.trophy,
                      color: total_color,
                      size: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Goal : ',
                          style: TextStyle(fontSize: 15, color: bg),
                        ),
                        Text(
                          '60%',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: bg),
                        )
                      ],
                    ),
                    Container(
                        height: 75,
                        width: 75,
                        child: Image.asset('assets/profile.png')),
                  ],
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
                            size: 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Stats()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: button_decor,
                          child: FaIcon(
                            FontAwesomeIcons.chartBar,
                            color: title_color,
                            size: 15,
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
                            size: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: button_decor,
                        child: FaIcon(
                          FontAwesomeIcons.infoCircle,
                          color: title_color,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Percent(),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Add_sub()));
                  },
                  child: Container(
                    width: 75,
                    height: 30,
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
        ],
      ),
    );
  }
}

class Percent extends StatefulWidget {
  @override
  _PercentState createState() => _PercentState();
}

class _PercentState extends State<Percent> {
  double _progress = .70;
  @override
  Widget build(BuildContext context) {
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
