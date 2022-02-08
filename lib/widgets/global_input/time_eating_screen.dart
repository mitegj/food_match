import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:morning_brief/utils/notification_scheduler.dart' as nt;

// ignore: must_be_immutable
class TimeEatingScreen extends StatelessWidget {
  TimeEatingScreen({Key? key, required this.isFirstLogin}) : super(key: key);
  final bool isFirstLogin;
  Rx<DateTime> _dateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    nt.Notification().requestPermissions();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          !isFirstLogin ? ArrowHeader() : SizedBox(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("NOTIFICATION".tr,
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("LABELENABLENOTIFICATION".tr,
                          style: GoogleFonts.poppins(
                              color: UIColors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                )),
            Expanded(flex: 3, child: hourMinute12HCustomStyle()),
            Obx(
              () => Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "LABELTIMENOTIFICATION".tr +
                          _dateTime.value.hour.toString().padLeft(2, '0') +
                          ':' +
                          _dateTime.value.minute.toString().padLeft(2, '0'),
                      style: GoogleFonts.poppins(
                          color: UIColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                saveNotificationDinnerTime();

                HapticFeedback.mediumImpact();
                if (isFirstLogin)
                  Get.offAll(() => HomePage(isFirstLogin: true));
                else
                  Get.back();
              },
              child: Container(
                width: mediaQuery.size.height * 1,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: UIColors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(isFirstLogin ? 'NEXT'.tr : 'DONE'.tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget hourMinute12HCustomStyle() {
    return new TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle: GoogleFonts.poppins(
          color: UIColors.grey, fontSize: 20, fontWeight: FontWeight.w300),
      highlightedTextStyle: GoogleFonts.poppins(
          color: UIColors.blue, fontSize: 20, fontWeight: FontWeight.w700),
      spacing: 40,
      isForce2Digits: false,
      minutesInterval: 5,
      alignment: Alignment.center,
      onTimeChange: (time) {
        _dateTime.value = time;
      },
    );
  }

  Future<void> saveNotificationDinnerTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dt = _dateTime.value.toString().split(' ')[1];
    prefs.setString('dinnerTime', dt);
    nt.Notification().initState();
  }
}
