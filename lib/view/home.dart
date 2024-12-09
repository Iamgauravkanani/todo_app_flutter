import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/config/colors.dart';
import 'package:todo_app/config/constatnt.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/assets.dart';
import '../config/global_widget.dart';
import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    String shareApp = "https://play.google.com/store/games?device=windows";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        confirmDialog();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 9.heightBox(),
          backgroundColor: AppColors.primaryColor,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          title: Text(
            "To-Do App",
            style: commonStyle(
              fontSize: 23,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    PopupMenuItem(
                        child: const Text("Rate App"),
                        onTap: () async {
                          if (await canLaunch(shareApp)) {
                            await launch(shareApp);
                          } else {
                            throw 'Could not launch $shareApp';
                          }
                        }),
                    PopupMenuItem(
                        child: const Text("Share App"),
                        onTap: () {
                          Share.share(shareApp);
                        }),
                  ];
                },
                child: Icon(Icons.more_vert_outlined,
                    size: 28, color: Colors.white)),
            10.width,
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor,
          onPressed: () => showAddTaskDialog(),
          label: Text(
            'Add TO-DO',
            style: Constant.myStyle(color: Constant.white),
          ),
          icon: Icon(
            Icons.add,
            color: Constant.white,
          ),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   gradient: RadialGradient(
          //     colors: [AppColors.primaryColor, Colors.white],
          //   ),
          // ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ));
            } else if (controller.todoData.isEmpty) {
              return Center(
                child: Image.asset(
                  Assets.emptyList,
                  height: 30.heightBox(),
                  width: 50.widthBox(),
                ),
              );
            } else {
              return ListView.builder(
                padding: 16.symmetric,
                itemCount: controller.todoData.length,
                itemBuilder: (context, i) {
                  var todo = controller.todoData[i];
                  return Padding(
                    padding: 10.onlyBottom,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.task,
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: commonStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        leading: Text(
                          "${i + 1}",
                          style: commonStyle(
                            fontWeight: FontWeight.w200,
                            color: AppColors.grey,
                          ),
                        ),
                        subtitle: Text(
                          "Date: ${todo.date}\nTime: ${todo.time}",
                          style: commonStyle(
                            fontWeight: FontWeight.w200,
                            color: AppColors.grey,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset(
                                AppSvg.delete,
                                height: 2.5.heightBox(),
                                width: 1.widthBox(),
                                fit: BoxFit.contain,
                                color: AppColors.red,
                              ),
                              onTap: () {
                                controller.deleteTask(todo.id!, i);
                              },
                            ),
                            15.height,
                            GestureDetector(
                              child: Icon(
                                Icons.edit,
                                size: 2.5.heightBox(),
                                color: AppColors.primaryColor,
                              ),
                              onTap: () {
                                Get.defaultDialog(
                                    backgroundColor: Colors.white,
                                    titleStyle: commonStyle(fontSize: 20),
                                    titlePadding: 20.onlyTop,
                                    barrierDismissible: false,
                                    title: "Update Task",
                                    content: PopScope(
                                      canPop: false,
                                      child: Text(
                                        "Are you want to Update Task??",
                                        style: commonStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.grey),
                                      ),
                                    ),
                                    confirm: Padding(
                                      padding: 10.onlyBottom,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                            onPressed: () async {
                                              Get.back();
                                              controller.updateTask(todo);
                                            },
                                            label: "Update",
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
