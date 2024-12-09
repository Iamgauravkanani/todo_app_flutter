import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/global_widget.dart';

import '../config/colors.dart';
import '../config/constatnt.dart';
import '../controller/onboarding_contr.dart';

class OnBoarding extends StatelessWidget {
  OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              itemCount: controller.pages.length,
              controller: controller.pageController,
              onPageChanged: (int page) {
                controller.selectedIndex.value = page;
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    10.height,
                    Image.asset(
                      controller.pages[index]['img']!,
                      height: 40.heightBox(),
                      width: 50.widthBox(),
                      fit: BoxFit.contain,
                    ),
                    10.height,
                    Text(
                      controller.pages[index]['text_1']!,
                      style: Constant.myStyle(
                        color: Colors.black,
                        fontsize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.height,
                    Text(
                      controller.pages[index]['text_2']!,
                      textAlign: TextAlign.center,
                      style: Constant.myStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          // Buttons
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.skipOnBoarding();
                    },
                    child: Text(
                      "SKIP",
                      style: Constant.myStyle(color: Colors.grey),
                    ),
                  ),
                  primaryBtn(
                    onPressed: () {
                      controller.nextPage();
                    },
                    label: 'NEXT',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: 4.horizontal,
      height: 0.6.heightBox(),
      width: isActive ? 10.widthBox() : 5.widthBox(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isActive ? Colors.black : AppColors.indicatorColor,
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    return List.generate(
      controller.pages.length,
      (index) => Obx(() => _indicator(controller.selectedIndex.value == index)),
    );
  }
}
