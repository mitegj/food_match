import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:morning_brief/utils/UIColors.dart';

// ignore: must_be_immutable
class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.85,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 60,
                  child:
                      Divider(height: 5, color: UIColors.black, thickness: 4)),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Hey Artenis,ti diamo il benvenuto su foodmatch.",
                style: GoogleFonts.poppins(
                    color: UIColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                Text(" Disclaimer:",
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Text(
                "Ti consigliamo di fare attenzione e di utilizzare le informazioni che sono riportare sull'app e sulle ricette con cautela.",
                style: GoogleFonts.poppins(
                    color: UIColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.assistant,
                  color: Colors.white,
                ),
                Text(" Come usare foodmatch:",
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Text("Spiegazione su come funziona l'app e cosa può fare",
                style: GoogleFonts.poppins(
                    color: UIColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Iniziamo',
                  style: GoogleFonts.poppins(
                      color: UIColors.detailBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            )
          ]),
    );
  }
}
