import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';

class FiltersPage extends StatelessWidget {
  FiltersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text("ANYPREFERENCES".tr + "?",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              )),
          FilterBody()
        ])));
  }
}
