import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import "package:get/get.dart";

class PreviewPageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/images/previewB.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "SELECTWHATYOU".tr + "\n" + "HAVEATHOME".tr,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "AND".tr + " . . .",
              style: GoogleFonts.poppins(
                  color: UIColors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
          ],
        ));
  }
}
