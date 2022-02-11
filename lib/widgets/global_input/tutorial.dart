import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/setting_controller.dart';

import 'package:morning_brief/utils/UIColors.dart';

// ignore: must_be_immutable
class Tutorial extends StatelessWidget {
  SettingController _settingController =
      Get.put<SettingController>(SettingController());
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.85,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    width: 60,
                    child: Divider(
                        height: 5, color: UIColors.black, thickness: 4)),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                  "✌️ Hey " +
                      (_settingController.hasUserName()
                          ? FirebaseAuth.instance.currentUser!.displayName!
                          : ''),
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              Text("WELCOMETEST".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Icon(Icons.help, color: UIColors.lightRed),
                  Text(" Disclaimer:",
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Text("DISCLAIMER".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    Icons.assistant,
                    color: UIColors.violet,
                  ),
                  Text("HOWTOUSEFOODMATCH".tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Text("HOWTHEAPPWORKS".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    text: "PRESSTHEBUTTON".tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.view_headline,
                            color: UIColors.violetMain),
                      ),
                      TextSpan(
                          text: "ADDINGREDIENTSLABEL".tr,
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ]),
              ),
              const SizedBox(height: 10),
              Text("LABELCREATEALLRECIPE".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Text("DISCOVERLABEL".tr + " 💪",
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: UIColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'LETSTART'.tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.detailBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
