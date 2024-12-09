import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/assets.dart';

class OnBoardingController extends GetxController {
  var selectedIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  List<Map<String, String>> pages = [
    {
      "img": Assets.path1,
      'text_1': "Manage your tasks",
      'text_2':
          "You can easily manage all of your daily\ntasks in DoMe for free",
    },
    {
      "img": Assets.path2,
      'text_1': "Create daily routine",
      'text_2':
          "In Uptodo  you can create your\npersonalized routine to stay productive",
    },
    {
      "img": Assets.path3,
      'text_1': "Organize your tasks",
      'text_2':
          "You can organize your daily tasks by\nadding your tasks into separate categories",
    },
  ];

  Future<void> skipOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('openFirst', true);
    Get.offAndToNamed('start');
  }

  void nextPage() async {
    if (selectedIndex.value == 2) {
      await skipOnBoarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
