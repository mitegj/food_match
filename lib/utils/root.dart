import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:morning_brief/utils/notification_scheduler.dart' as nt;

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    resetLimitMultiplier();

    nt.Notification().initState();
    AuthController.instance.checkUpdates();
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Center(
            child: Text("Welcome 🤙",
                style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))));
  }

  resetLimitMultiplier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("limitMultiplier", 1);

    prefs.setInt("menuLength", 0);
  }
}
