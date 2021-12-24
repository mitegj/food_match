import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

class ConfirmCooked extends StatelessWidget {
  const ConfirmCooked({Key? key, required this.cooked}) : super(key: key);
  final bool cooked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cooked ? UIColors.lightGreen : UIColors.orange,
      body: InkWell(
        onTap: () {
          if (cooked == true) {
            Get.back();
            Navigator.pop(context);
          } else {
            Get.back();
          }
        },
        child: SafeArea(
          child: Container(
            child: Center(
              child: cooked ? cookedTrue() : cookedFalse(),
            ),
          ),
        ),
      ),
    );
  }

  Column cookedTrue() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "🤙",
          style: TextStyle(fontSize: 40),
        ),
        Text(
          "Ottimo lavoro.",
          style: GoogleFonts.poppins(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "(tap ovunque per continuare)",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

  Column cookedFalse() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "😲",
          style: TextStyle(fontSize: 40),
        ),
        Text(
          "mhhhh...",
          style: GoogleFonts.poppins(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "troppo veloce per averlo cucinato.",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "(tap ovunque per continuare)",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
