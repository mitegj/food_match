import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/preview.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/onBoarding/authButtons/apple_login.dart';
import 'package:morning_brief/widgets/onBoarding/authButtons/google_login.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => PreviewPage());
                    },
                    child: Text(
                      "Preview",
                      style: GoogleFonts.poppins(
                        color: UIColors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset("assets/images/onboarding.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Food",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Not a regular \n"
                                    "food app!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Match.",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Embrace a new way to enjoy cooking your meals and finding new recipes.",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: new GoogleLogin(),
                    ),
                    new AppleLogin(onPressed: () {
                      print('Apple Auth');
                    })
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
