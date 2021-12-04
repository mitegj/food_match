import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

class PreviewPageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
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
              "TUTORIAL 2 \n",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "tutorial 2!",
              style: GoogleFonts.poppins(
                  color: UIColors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
          ],
        ));
  }
}
