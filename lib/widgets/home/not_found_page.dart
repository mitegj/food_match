import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.blue,
      body: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
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
        Text(
          "Ops",
          style: GoogleFonts.poppins(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "SAVEDFORLATER".tr,
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
