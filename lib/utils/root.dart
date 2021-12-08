import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/user_controller.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/screens/onboarding.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        controller.checkUpdates();
        if (controller.user?.uid != null) {
          return HomePage();
          /*return RaisedButton(
            child: Text("Log out"),
            onPressed: () {
              controller.logoutGoogle();
            },
          );*/
          // return SearchPage();
        } else {
          return OnBoardingPage();
        }
      },
    );
  }
}
