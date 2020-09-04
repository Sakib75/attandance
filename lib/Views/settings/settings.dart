import 'package:attandace_app/Views/home.dart';
import 'package:attandace_app/Views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  double _value = 60;
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animation2;

  _SetGoal(goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('Pressed $goal times.');
    await prefs.setInt('goal', goal);
  }

  getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = await prefs.getInt('goal');
    setState(() {
      _value = intValue != null ? intValue.toDouble() : 60;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // controller.forward();
        }
      });
    animation2 = Tween<double>(begin: 1, end: 10 * pi).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // controller.reverse();
          Future.delayed(Duration(milliseconds: 500));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));

          print(status);
        } else if (status == AnimationStatus.dismissed) {
          // controller.forward();

        }
      });
    getInt();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    bool isTap = false;
    return Scaffold(
      backgroundColor: bg,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Set Your Goal',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: title_color),
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
                                    colors: [
                                      title_color,
                                      Colors.transparent
                                    ]).createShader(rect);
                              },
                              child: Container(
                                height: size,
                                width: size,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          Image.asset('assets/radial_scale.png')
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
                                decoration: BoxDecoration(
                                    color: bg, shape: BoxShape.circle),
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
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                    child: Slider(
                      min: 0,
                      max: 100,
                      divisions: 100,
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
                    _SetGoal(_value.ceil());
                    print(_value.ceil());
                    controller.forward();
                  },
                  child: Container(
                    height: size / 3,
                    width: size,
                    decoration: isTap ? null : card_decor,
                    child: Center(
                      child: Text(
                        'Set Goal',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            AnimatedPositioned(
                top: MediaQuery.of(context).size.height / 2 - 100,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Container(
                      child: Transform.scale(
                        scale: animation.value,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff89cff0), width: 5),
                              color: title_color,
                              borderRadius: BorderRadius.circular(100)),
                          height: 200,
                          width: 200,
                          child: Transform.rotate(
                            angle: sin(animation2.value),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                size: 100,
                                color: Color(0xff89cff0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                duration: Duration(milliseconds: 500))
          ],
        ),
      ),
    );
  }
}
