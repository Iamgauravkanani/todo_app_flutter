import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/home.dart';
import 'package:todo_app/view/onboarding.dart';
import 'package:todo_app/view/splash.dart';
import 'package:todo_app/view/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => const Splash(),
          'onBoarding': (ctx) => OnBoarding(),
          'start': (ctx) => const Start(),
          'home': (ctx) => Home(),
        },
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2.5}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

// flutter version==>>3.22.3
