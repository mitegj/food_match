import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:morning_brief/widgets/onBoarding/authButtons/apple_login.dart';
import 'package:morning_brief/widgets/onBoarding/authButtons/google_login.dart';

// ignore: must_be_immutable
class OnBoardingPage extends StatelessWidget {
  Conf conf = new Conf();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    RxBool checked = false.obs;
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 0),
                  child: RichText(
                    text: TextSpan(
                        text: "SLOGAN1".tr +
                            "\n" +
                            "SLOGAN2".tr +
                            "\n" +
                            "SLOGAN3".tr +
                            ",",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "\n" + "SLOGAN4".tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 40,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decorationColor: UIColors.violet,
                                  fontWeight: FontWeight.w500)),
                        ]),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: UIColors.detailBlack.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Theme(
                            data: ThemeData(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                unselectedWidgetColor:
                                    Colors.white.withOpacity(0.6)),
                            child: Checkbox(
                              checkColor: UIColors.green,
                              activeColor: UIColors.green,
                              value: checked.value,
                              onChanged: (bool? value) {
                                checked.value = value!;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                text: "TERMSANDCONDITIONS".tr,
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13),
                                children: <TextSpan>[
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          var lng = conf.iubendaLink[conf.lang];
                                          String url = lng!["terms"].toString();
                                          conf.launchURL(url);
                                        },
                                      text: " " + "CONDITIONSTERMS".tr,
                                      style: TextStyle(
                                          color: UIColors.violet,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: " " + "AND".tr.toLowerCase() + " "),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          var lng = conf.iubendaLink[conf.lang];
                                          String url =
                                              lng!["privacy"].toString();
                                          conf.launchURL(url);
                                        },
                                      text: "PRIVACYPOLICY".tr + ".",
                                      style: TextStyle(
                                          color: UIColors.violet,
                                          fontWeight: FontWeight.w600))
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppleLogin(
                      checked: checked,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GoogleLogin(
                      checked: checked,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
