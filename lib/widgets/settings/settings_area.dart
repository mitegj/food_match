import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:morning_brief/widgets/global_input/time_eating_screen.dart';

// ignore: must_be_immutable
class SettingsArea extends StatelessWidget {
  Conf conf = new Conf();

  SettingsArea({
    Key? key,
    required SettingController settingController,
    required AuthController authController,
  })  : _settingController = settingController,
        _authController = authController,
        super(key: key);

  final SettingController _settingController;
  final AuthController _authController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 20),
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
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
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
                    backgroundColor: UIColors.lightblueTile.withOpacity(0.2),
                    child: Icon(Icons.sick, color: UIColors.lightblueTile),
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
              Get.to(() => TimeEatingScreen(
                    isFirstLogin: false,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
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
                    backgroundColor: UIColors.blue.withOpacity(0.2),
                    child: Icon(
                      Icons.notifications_on,
                      color: UIColors.blue,
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
              var lng = conf.appAppStroreLink;
              conf.launchURL(lng);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("5STAR".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.orange.withOpacity(0.2),
                    child: Icon(
                      Icons.star,
                      color: UIColors.orange,
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
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
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
                    backgroundColor: UIColors.lightGreen.withOpacity(0.2),
                    child: Icon(
                      Icons.help,
                      color: UIColors.lightGreen,
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
              var lng = conf.iubendaLink[conf.lang];
              String url = lng!["privacy"].toString();
              conf.launchURL(url);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
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
                    backgroundColor: UIColors.metallic.withOpacity(0.2),
                    child: Icon(
                      Icons.privacy_tip,
                      color: UIColors.metallic,
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
              var lng = conf.iubendaLink[conf.lang];
              String url = lng!["terms"].toString();
              conf.launchURL(url);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CONDITIONSTERMS".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: UIColors.violet.withOpacity(0.2),
                    child: Icon(
                      Icons.tour_rounded,
                      color: UIColors.violet,
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
              HapticFeedback.mediumImpact();
              _authController.logout();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DISCONNECTACCOUNT".tr,
                      style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
                  CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    child: Icon(
                      Icons.exit_to_app_sharp,
                      color: Colors.red[500],
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
