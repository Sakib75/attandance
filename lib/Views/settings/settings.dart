import 'package:attandace_app/Views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _value = 60;
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    bool isTap = false;
    return Scaffold(
      backgroundColor: bg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Your Goal',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: title_color),
          ),
          TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 3),
              builder: (context, value, child) {
                return Container(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                                  startAngle: 0.0,
                                  endAngle: 2 * pi,
                                  stops: [_value / 100, _value / 100],
                                  center: Alignment.center,
                                  colors: [title_color, Colors.transparent])
                              .createShader(rect);
                        },
                        child: Container(
                          height: size,
                          width: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: Image.asset('assets/radial_scale.png')
                                    .image),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Center(
                            child: Text(
                              '${_value.toStringAsFixed(0)}',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: title_color),
                            ),
                          ),
                          width: size - 40,
                          height: size - 40,
                          decoration:
                              BoxDecoration(color: bg, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                );
              }),
          Container(
            height: 200,
            width: 400,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: title_color,
                inactiveTrackColor: total_color,
                trackShape: RectangularSliderTrackShape(),
                trackHeight: 4.0,
                thumbColor: title_color,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              ),
              child: Slider(
                min: 0,
                max: 100,
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTap = true;
              });
            },
            onTapCancel: () {
              setState(() {
                isTap = false;
              });
            },
            child: Container(
              height: size / 3,
              width: size,
              decoration: isTap ? null : card_decor,
              child: Center(
                child: Text(
                  'Set Goal',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
