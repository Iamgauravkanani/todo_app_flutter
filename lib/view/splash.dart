import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/config/colors.dart';

import '../config/assets.dart';
import '../config/constatnt.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? openFirst = prefs.getBool('openFirst') ?? false;
        if (openFirst) {
          Get.offAndToNamed('home');
        } else {
          Get.offAndToNamed('onBoarding');
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.splash,
              height: 10.heightBox(),
              width: 30.widthBox(),
              fit: BoxFit.contain,
              color: AppColors.primaryColor,
            ),
            10.height,
            Text(
              "UpTodo",
              style:
                  Constant.myStyle(fontsize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
