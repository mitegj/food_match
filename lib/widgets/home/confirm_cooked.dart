import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/utils/UIColors.dart';

// ignore: must_be_immutable
class ConfirmCooked extends StatelessWidget {
  ConfirmCooked({Key? key, required this.cooked, required this.fromStepsPage})
      : super(key: key);
  final bool cooked;
  final bool fromStepsPage;

  SettingController _settingController =
      Get.put<SettingController>(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cooked ? UIColors.lightGreen : UIColors.orange,
      body: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          if (cooked == true) {
            Navigator.pop(context);
          }
          if (fromStepsPage) {
            Get.off(() => HomePage(isFirstLogin: false));
          } else {
            Get.back();
          }
        },
        child: SafeArea(
          child: Container(
            child: Center(
              child: cooked ? cookedTrue() : cookedFalse(),
            ),
          ),
        ),
      ),
    );
  }

  Column cookedTrue() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "🤙",
          style: TextStyle(fontSize: 40),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "ENJOYOURMEAL".tr +
              " ${_settingController.hasUserName() ? FirebaseAuth.instance.currentUser!.displayName!.split(" ")[0] : ''} !",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
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

  Column cookedFalse() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "😲",
          style: TextStyle(fontSize: 40),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "mhhhh...",
          style: GoogleFonts.poppins(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "TOOFAST".tr,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
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
