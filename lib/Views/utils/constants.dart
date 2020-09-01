import 'package:flutter/material.dart';

BoxDecoration card_decor = BoxDecoration(boxShadow: [
  BoxShadow(
      offset: Offset(1, 1),
      color: Color(0xffD1D9E6),
      spreadRadius: 2,
      blurRadius: 2),
  BoxShadow(
      offset: Offset(-6, -6),
      color: Colors.white70,
      spreadRadius: 2,
      blurRadius: 7),
], color: Color(0xffECF0F3), borderRadius: BorderRadius.circular(25));

BoxDecoration button_decor = BoxDecoration(boxShadow: [
  BoxShadow(
      offset: Offset(-0.5, -0.5),
      color: Colors.white.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 3),
  BoxShadow(
      offset: Offset(1, 1), color: Colors.black, spreadRadius: 2, blurRadius: 3)
], shape: BoxShape.circle, color: Colors.white);
Color bg = Color(0xffECF0F3);
Color percentage_color = Color(0xff056404);
Color edit_color = Color(0xff8ea1b9);
Color present_color = Color(0xff93a1a6);
Color total_color = Color(0xff98b2c8);
Color title_color = Color(0xff677a94);
Color thumbsup_color = Color(0xff7DA93E);
