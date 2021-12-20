import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';
import 'package:morning_brief/widgets/home/filters_header.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class FiltersPage extends GetWidget<AllergyController> {
  FiltersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
              flex: 1,
              child: ArrowHeader(
                home: true,
              )),
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text("Do you have any kind of preferences?",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 31,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Select them with the filters!",
                            style: GoogleFonts.poppins(
                                color: UIColors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ],
                ),
              )),
          FilterHeader()
        ])));
  }
}
