import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:get/get.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';

class EmptyMenu extends StatelessWidget {
  EmptyMenu({
    Key? key,
    required this.savedMenu,
  }) : super(key: key);
  final bool savedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            children: [
              savedMenu ? ArrowHeader() : SizedBox(),
              Expanded(
                child: Text("SAVEDMENU".tr,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Text("TRYADDSOMEBASICPRODUCT".tr,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                        color: UIColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
              )
            ],
          ),
        )
      ],
    );
  }
}
