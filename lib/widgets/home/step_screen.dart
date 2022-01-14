import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/utils/conf.dart';

class StepScreen extends StatelessWidget {
  StepScreen({Key? key, required this.menu}) : super(key: key);
  final MenuModel menu;

  RxBool _speak = true.obs;
  RxInt index = 0.obs;
  FlutterTts tts = FlutterTts();
  Conf conf = Conf();

  speak(String text) async {
    // await tts.setLanguage(conf.language);
    await Future.delayed(Duration(seconds: 1));
    await tts.setVoice({"name": "Karen", "locale": conf.language});
    await tts.setPitch(1.2);
    await tts.speak(text);
  }

  stopSpeak() async {
    await tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    speak(menu.steps[index.value]);
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final localOffset = box.globalToLocal(details.globalPosition);
        final x = localOffset.dx;
        if (x > box.size.width / 2 + 10 || x < box.size.width / 2 - 10) if (x <
            box.size.width / 3) {
          if (index.value != 0) {
            index.value -= 1;
          }
        } else {
          if (index.value + 1 == menu.steps.length) {
            MenuController menuController = Get.find<MenuController>();
            menuController.checkBeforeSaveMenu(menu, true);
            Get.back();
            Navigator.pop(context);
          } else {
            index.value += 1;
            if (_speak.value) speak(menu.steps[index.value]);
          }
        }
      },
      child: Scaffold(
        backgroundColor: UIColors.azure,
        body: SafeArea(
          child: Container(
            child: Center(
              child: cookedTrue(),
            ),
          ),
        ),
      ),
    );
  }

  Widget cookedTrue() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: UIColors.black,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    (index.value + 1).toString() +
                        " / " +
                        menu.steps.length.toString(),
                    style: GoogleFonts.poppins(
                        color: UIColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: UIColors.black,
                  size: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              menu.steps[index.value],
              style: GoogleFonts.poppins(
                  color: UIColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  // onTap: speak(menu.steps[index.value]),
                  onTap: () {
                    stopSpeak();
                    _speak.value = !_speak.value;
                  },
                  child: Icon(
                    _speak.value
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    size: 40,
                    color: UIColors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "(" + "TAPANYWARE".tr + ")",
                  style: GoogleFonts.poppins(
                      color: UIColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
