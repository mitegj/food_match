import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/screens/contract.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/time_eating_screen.dart';

class SettingsArea extends StatelessWidget {
  const SettingsArea({
    Key? key,
    required SettingController settingController,
  })  : _settingController = settingController,
        super(key: key);

  final SettingController _settingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UIColors.detailBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => AllergiesScreen(
                    isFirstLogin: false,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ALLERGIES".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.black.withOpacity(0.6),
                    child: Icon(Icons.sick, color: UIColors.white),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: UIColors.black,
          ),
          InkWell(
            onTap: () {
              Get.to(TimeEatingScreen(
                isFirstLogin: false,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("NOTIFICATION".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.black.withOpacity(0.6),
                    child: Icon(
                      Icons.notifications_on,
                      color: UIColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: UIColors.black,
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SUPPORTUS".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.black.withOpacity(0.6),
                    child: Icon(
                      Icons.star,
                      color: UIColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: UIColors.black,
          ),
          InkWell(
            onTap: () {
              _settingController.openEmailFeedback();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("HELPASSISTANCE".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.black.withOpacity(0.6),
                    child: Icon(
                      Icons.help,
                      color: UIColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: UIColors.black,
          ),
          InkWell(
            onTap: () {
              Get.to(ContractScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("PRIVACYPOLICY".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.black.withOpacity(0.6),
                    child: Icon(
                      Icons.privacy_tip,
                      color: UIColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
