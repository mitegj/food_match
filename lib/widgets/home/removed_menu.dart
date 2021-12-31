import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

class RemovedMenu extends StatelessWidget {
  const RemovedMenu({Key? key, required this.context}) : super(key: key);

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.lightRed,
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
          Get.back();
        },
        child: SafeArea(
          child: Container(
            child: Center(
              child: reminderMenu(),
            ),
          ),
        ),
      ),
    );
  }

  Column reminderMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "❌",
          style: TextStyle(fontSize: 40),
        ),
        Text(
          "REMOVED".tr,
          style: GoogleFonts.poppins(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "MENUREMOVED".tr,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "(" + "TAPANYWARE".tr + ")",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
