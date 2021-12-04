import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/onboarding.dart';
import 'package:morning_brief/utils/UIColors.dart';

class PreviewPageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset("assets/images/previewC.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Text(
                      "We will suggest \n"
                      "you new recipes \n"
                      "everyday.",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "Now, it's your turn!",
                        style: GoogleFonts.poppins(
                            color: UIColors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    InkWell(
                      onTap: () => {Get.back()},
                      child: CircleAvatar(
                        backgroundColor: UIColors.white,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: UIColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //BottomOptions(activePage: (3), totalPages: 3)
            ]));
  }
}
