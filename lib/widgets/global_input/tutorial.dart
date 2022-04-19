import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';

// ignore: must_be_immutable
class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StepScreen();
  }
}

// ignore: must_be_immutable
class StepScreen extends StatelessWidget {
  StepScreen({Key? key}) : super(key: key);

  RxInt index = 0.obs;
  FlutterTts tts = FlutterTts();
  var indextex = 5;
  var lisdescription = [
    "TUTORIALLABEL1",
    "DISCLAIMER",
    "TUTORIAL2",
    "LABELCREATEALLRECIPE",
    "LETSTART"
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final localOffset = box.globalToLocal(details.globalPosition);
        final x = localOffset.dx;
        final y = localOffset.dy;
        if (y < box.size.height * 0.85) {
          if (x > box.size.width / 2 + 10 ||
              x < box.size.width / 2 - 10) if (x < box.size.width / 3) {
            if (index.value != 0) {
              index.value -= 1;
            }
          } else {
            if (index.value + 1 == indextex) {
              try {} catch (e) {}

              Get.back();
            } else {
              index.value += 1;
            }

            HapticFeedback.lightImpact();
          }
        }
      },
      child: Container(
        height: mediaQuery.size.height * 0.92,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
            color: UIColors.white),
        child: cookedTrue(),
      ),
    );
  }

  Widget cookedTrue() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 60,
                child: Divider(height: 5, color: UIColors.black, thickness: 4)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    (index.value + 1).toString() + " / 5",
                    style: GoogleFonts.poppins(
                        color: UIColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  "TAPANYWARE".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              lisdescription[index.value].tr,
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  color: UIColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
