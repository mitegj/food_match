import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/auth_controller2.dart';
import 'package:morning_brief/controllers/user_controller.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/screens/onboarding.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControllerDue>(
      init: AuthControllerDue(),
      builder: (_) {
        return _.user?.uid != null ? HomePage() : OnBoardingPage();
      },
    );
  }
}
