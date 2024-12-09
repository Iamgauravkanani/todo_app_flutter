import 'package:flutter/material.dart';

import '../config/assets.dart';
import '../config/colors.dart';
import '../config/constatnt.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.height,
          Text("Welcome to UpTodo",
              style:
                  Constant.myStyle(fontsize: 32, fontWeight: FontWeight.bold)),
          10.height,
          // Text(
          //   'Please login to your account or create\nnew account to continue',
          //   style: Constant.myStyle(),
          //   textAlign: TextAlign.center,
          // ),
          // 40.height,
          Image.asset(
            Assets.start,
            height: 25.heightBox(),
            width: 60.widthBox(),
            fit: BoxFit.cover,
          ),
          40.height,
          Text(
            "What do you want to do Today?",
            style: Constant.myStyle(fontsize: 20),
          ),
          Text(
            "Tap Button to add your tasks",
            style: Constant.myStyle(),
          ),
          100.height,
          Padding(
            padding: 20.horizontal,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'GET STARTED',
                style: Constant.myStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
