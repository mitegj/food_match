import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

class EmptyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("We have no advices for you. ",
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                    "Try adding some of those basic products by clicking the following shortcut button! ",
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                        color: UIColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
              )
            ],
          )
        ],
      ),
    );
  }
}
