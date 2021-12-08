import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';

class SettingsBody extends GetWidget<SettingController> {
  SettingController _settingController =
      Get.put<SettingController>(SettingController());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 6,
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.detailBlack),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Dati personali',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => AllergiesScreen());
                      },
                      child: Text(
                        'Allergie',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Support us with 5 star',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _settingController.openEmailFeedback();
                      },
                      child: Text(
                        'Help and assistence',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Privacy policy',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: mediaQuery.size.width * 1,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: UIColors.detailBlack,
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                // TODO: Logout da google
                _settingController.logout();
              },
              child: Text(
                'Disconetti account',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Cancella account',
                  style: GoogleFonts.poppins(
                    color: theme.secondaryHeaderColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Obx(() => Text(
                  _settingController.appCurrentVersion.value,
                  style: GoogleFonts.poppins(
                    color: theme.secondaryHeaderColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
