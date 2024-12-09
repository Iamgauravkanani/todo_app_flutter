import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/constatnt.dart';
import 'package:todo_app/controller/home_controller.dart';

import 'assets.dart';
import 'colors.dart';

OutlineInputBorder myBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black),
    );

Widget commonDialogBtn(
    {required void Function() onTap,
    required String label,
    required String img,
    required Color color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 6.heightBox(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.7), width: 0.7),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              img,
              height: 3.heightBox(),
              width: 3.widthBox(),
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                label,
                style: commonStyle(
                    fontSize: 13, color: color, fontWeight: FontWeight.w500
                    //     time == null ? AppColors.grey : Colors.black,
                    ),
              ))
        ],
      ),
    ),
  );
}

Widget primaryBtn({required void Function()? onPressed, required label}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      minimumSize: const Size(90, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: Text(
      label,
      style: Constant.myStyle(color: Colors.white),
    ),
  );
}

TextStyle commonStyle({
  double fontSize = 14,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w600,
  FontStyle fontStyle = FontStyle.normal,
  String fontFamily = 'Roboto',
  double letterSpacing = 0,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontStyle: fontStyle,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
  );
}

Future<bool?> primaryToast({required msg}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showAddTaskDialog() {
  HomeController controller = Get.find();
  Get.defaultDialog(
    titleStyle: commonStyle(fontSize: 20),
    titlePadding: 20.vertical,
    backgroundColor: Colors.white,
    barrierDismissible: false,
    title: "Add Task",
    content: PopScope(
      canPop: false,
      child: Column(
        children: [
          Container(
            height: 6.heightBox(),
            decoration: BoxDecoration(color: Colors.white),
            child: TextFormField(
              controller: controller.taskCon,
              onChanged: (val) {
                controller.task.value = val;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 13, left: 13),
                hintText: 'add task here',
                border: myBorder(),
                enabled: true,
                focusedBorder: myBorder(),
              ),
            ),
          ),
          10.height,
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => commonDialogBtn(
                      onTap: () {
                        controller.pickDate();
                      },
                      img: AppSvg.calender,
                      label: controller.showDate.value.isEmpty
                          ? "Pick Date"
                          : controller.showDate.value,
                      color: controller.showDate.value.isEmpty
                          ? AppColors.grey
                          : Colors.black),
                ),
              ),
              10.width,
              Expanded(
                child: Obx(
                  () => commonDialogBtn(
                      onTap: () {
                        controller.pickTime();
                      },
                      img: AppSvg.watch,
                      label: controller.showTime.value.isEmpty
                          ? "Pick Time"
                          : controller.showTime.value,
                      color: controller.showTime.value.isEmpty
                          ? AppColors.grey
                          : Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    confirm: Padding(
      padding: 10.onlyBottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          primaryBtn(
            label: 'Cancel',
            onPressed: () {
              controller.taskCon.clear();
              controller.task.isEmpty;
              controller.date.value = null;
              controller.showDate.value = '';
              controller.time.value = null;
              controller.showTime.value = '';
              Get.back();
            },
          ),
          primaryBtn(
              onPressed: () {
                controller.addTask();
              },
              label: "Add"),
        ],
      ),
    ),
  );
}

void confirmDialog() {
  Get.defaultDialog(
    backgroundColor: Colors.white,
    titleStyle: commonStyle(
        fontSize: 25, color: Colors.black, fontWeight: FontWeight.w600),
    titlePadding: 20.onlyTop,
    barrierDismissible: false,
    title: "Confirm Exit!!!",
    content: Text(
      "Are you sure you want to exit?",
      textAlign: TextAlign.center,
      style: commonStyle(
          fontSize: 15, color: AppColors.grey, fontWeight: FontWeight.w500),
    ),
    confirm: Padding(
      padding: 10.onlyBottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          primaryBtn(
            onPressed: () {
              Get.back();
            },
            label: 'No',
          ),
          primaryBtn(
            onPressed: () {
              SystemNavigator.pop();
            },
            label: 'Yes',
          ),
        ],
      ),
    ),
  );
}
