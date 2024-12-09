import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/constatnt.dart';

import '../config/assets.dart';
import '../config/colors.dart';
import '../config/global_widget.dart';
import '../config/helpers/db_helper.dart';
import '../model/todo_model.dart';

class HomeController extends GetxController {
  var todoData = <TODO>[].obs;
  var isLoading = true.obs;

  var task = ''.obs;
  var date = Rxn<DateTime>();
  var time = Rxn<TimeOfDay>();
  var showDate = ''.obs;
  var showTime = ''.obs;

  TextEditingController taskCon = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    todoData.value = await DBHelper.dbHelper.fetchTask() ?? [];
    isLoading.value = false;
  }

  Future<void> addTask() async {
    if (task.isNotEmpty && date.value != null && time.value != null) {
      TODO todo = TODO(
        date: '${date.value?.day}/${date.value?.month}/${date.value?.year}',
        task: task.value,
        time: '${time.value?.hour}:${time.value?.minute}',
      );
      await DBHelper.dbHelper.insertTodo(todo: todo);

      fetchTasks();
      Get.back();
      resetTaskInputs();
    } else {
      primaryToast(msg: 'Please Enter All Data..');
    }
  }

  Future<void> deleteTask(int id, int index) async {
    await DBHelper.dbHelper.deleteTask(d_id: id);
    todoData.removeAt(index);
  }

  Future<void> updateTask(TODO todo) async {
    HomeController homeController = Get.find();
    taskCon.text = todo.task;

    List<String> dateParts = todo.date.split('/');
    date.value = DateTime(
      int.parse(dateParts[2]), // Year
      int.parse(dateParts[1]), // Month
      int.parse(dateParts[0]), // Day
    );
    showDate.value =
        '${date.value?.day}/${date.value?.month}/${date.value?.year}';

    List<String> timeParts = todo.time.split(':');
    time.value = TimeOfDay(
      hour: int.parse(timeParts[0]), // Hour
      minute: int.parse(timeParts[1]), // Minute
    );
    showTime.value = '${timeParts[0]}:${timeParts[1].padLeft(2, '0')}';
    // showTime.value = todo.time;

    Get.defaultDialog(
        backgroundColor: Colors.white,
        titleStyle: commonStyle(fontSize: 20),
        titlePadding: 20.onlyTop,
        barrierDismissible: false,
        title: "Update Task",
        content: PopScope(
          canPop: false,
          child: Column(
            children: [
              Container(
                height: 6.heightBox(),
                decoration: BoxDecoration(color: Colors.white),
                child: TextFormField(
                  controller: homeController.taskCon,
                  onChanged: (val) {
                    homeController.task.value = val;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 13, left: 13),
                    hintText: 'Update task here',
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
                            homeController.pickDate();
                          },
                          img: AppSvg.calender,
                          label: homeController.showDate.value.isEmpty
                              ? "Pick Date"
                              : homeController.showDate.value,
                          color: homeController.showDate.value.isEmpty
                              ? AppColors.grey
                              : Colors.black),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Obx(
                      () => commonDialogBtn(
                          onTap: () {
                            homeController.pickTime();
                          },
                          img: AppSvg.watch,
                          label: homeController.showTime.value.isEmpty
                              ? "Pick Time"
                              : homeController.showTime.value,
                          color: homeController.showTime.value.isEmpty
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
                  Get.back();
                  resetTaskInputs();
                },
              ),
              primaryBtn(
                  onPressed: () async {
                    TODO updatedTodo = TODO(
                      id: todo.id,
                      task: taskCon.text,
                      date:
                          '${date.value?.day}/${date.value?.month}/${date.value?.year}',
                      time: '${time.value?.hour}:${time.value?.minute}',
                    );
                    await DBHelper.dbHelper.updateTodo(
                      todo: updatedTodo,
                      u_id: todo.id!,
                    );
                    fetchTasks();
                    resetTaskInputs();

                    primaryToast(msg: 'Task updated successfully');
                    Get.back();
                    resetTaskInputs();
                  },
                  label: "Update"),
            ],
          ),
        ));
  }

  void resetTaskInputs() {
    taskCon.clear();
    task.value = '';
    date.value = null;
    time.value = null;
    showDate.value = '';
    showTime.value = '';
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: date.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
    if (pickedDate != null) {
      date.value = pickedDate;
      showDate.value =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: time.value ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      time.value = pickedTime;
      showTime.value = '${pickedTime.hour}:${pickedTime.minute}';
    }
  }
}
