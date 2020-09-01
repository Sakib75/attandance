import 'dart:math';

import 'package:attandace_app/Views/utils/constants.dart';
import 'package:flutter/material.dart';

class Percent extends StatefulWidget {
  @override
  _PercentState createState() => _PercentState();
}

class _PercentState extends State<Percent> {
  double _progress = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            painter: GradientArcPainter(
              progress: _progress,
              startColor: Color(0xff5f99c7),
              endColor: Colors.green,
              width: 16.0,
            ),
            child: Center(
                child: Text(
              '${(_progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
          ),
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
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -4 * pi / 3;
    final sweepAngle = 5 / 3 * pi * progress;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);

    canvas.drawShadow(path, Colors.grey.withAlpha(50), 4.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
