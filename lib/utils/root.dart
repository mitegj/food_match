import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';

import 'package:morning_brief/utils/notification_scheduler.dart' as nt;

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    resetLimitMultiplier();

    nt.Notification().initState();
    AuthController.instance.checkUpdates();
    HapticFeedback.heavyImpact();
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Center(
            child: Text("HELLO".tr + " ✌️",
                style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))));
  }

  resetLimitMultiplier() async {
    MenuController.limitMultiplier = 1;
  }
}
