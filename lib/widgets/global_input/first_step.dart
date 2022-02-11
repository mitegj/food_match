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
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: TextButton(
                          child: Text("NEXT".tr.toUpperCase(),
                              style: GoogleFonts.poppins(
                                  color: UIColors.violet,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            Get.to(() => AllergiesScreen(
                                  isFirstLogin: true,
                                ));
                          },
                        ),
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
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("WELCOME".tr + " 😎",
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(height: 20),
                      Text("STEP1LABEL1".tr + " ✨",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      Text("STEP1LABEL2".tr,
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
