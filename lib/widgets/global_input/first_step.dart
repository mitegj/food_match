import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';

class FirsStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Get.to(() => AllergiesScreen(
                                isFirstLogin: true,
                              ));
                        },
                        child: Text("NEXT".tr.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: UIColors.violet,
                                fontSize: 17,
                                fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("1/2",
                            style: GoogleFonts.poppins(
                                color: UIColors.white.withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Benvenuto" + " 😎",
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Ora ti chiederemo qualche piccola informazione prima di utilizzare foodmatch per rendere migliore la tua esperienza." +
                              " ✨",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "Se hai qualche tipo di allergia, dichiarala altrimenti premi avanti per continuare.",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
