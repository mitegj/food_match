import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    resetLimitMultiplier();
    AuthController.instance.checkUpdates();
    return LoadingWidget();
  }

  resetLimitMultiplier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("limitMultiplier", 1);
  }
}
