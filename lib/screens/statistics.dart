import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/controllers/statistic_controller.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';
import 'package:intl/intl.dart';
import 'package:morning_brief/widgets/home/home_header.dart';

class StatisticsScreen extends GetWidget<AllergyController> {
  StatisticsScreen({Key? key}) : super(key: key);
  List<Color> gradientColors = [
    UIColors.orange,
    UIColors.yellow,
  ];
  // https://pub.dev/packages/fl_chart

  StatisticController statisticController =
      Get.put<StatisticController>(StatisticController());

  SettingController _settingController =
      Get.put<SettingController>(SettingController());
  AuthController _authController = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    DateFormat formattedDate = DateFormat(
        Get.deviceLocale == "en" ? 'kk:mm  yyyy-MM-dd' : "kk:mm  dd-MM-yyyy");
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ArrowHeader(
                home: false,
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: UIColors.blue,
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.blue,
                  ),
                  child: Text(
                    "${FirebaseAuth.instance.currentUser!.displayName!.split('')[0] + FirebaseAuth.instance.currentUser!.displayName!.split(' ')[1].substring(0, 1)}",
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Calorie settimanali",
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Color(0xFF12161C)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 30.0, left: 5, top: 20, bottom: 10),
                          child: Obx(
                            () => LineChart(
                              mainData(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Container(
                width: mediaQuery.size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: UIColors.detailBlack,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.article_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Text("Storico settimanale",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Visibility(
                visible: false,
                child: Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.2,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 0),
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(15.0),
                          bottomRight: const Radius.circular(15.0))),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Piatto numero 1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Piatto numero 2",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Piatto numero 3",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            color: Colors.deepOrange,
                            child: Center(
                              child: Text(
                                'Carica altri elementi',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              child: Obx(() => statisticController.cookedMenus != null
                  ? (ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: statisticController.cookedMenus?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: UIColors.lightGreen,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.more_time_sharp),
                                Text(
                                    statisticController
                                        .cookedMenus![index].name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    formattedDate.format(
                                      statisticController
                                          .cookedMenus![index].cookedTime
                                          .toDate(),
                                    ),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300))
                              ],
                            ),
                          ),
                        );
                      }))
                  : Text("")),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Impostazioni",
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: UIColors.detailBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => AllergiesScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Allergie",
                              style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )),
                          CircleAvatar(
                            backgroundColor: UIColors.black.withOpacity(0.6),
                            child: Icon(
                              Icons.sick,
                              color: UIColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: UIColors.black,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Support us with 5 star",
                              style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )),
                          CircleAvatar(
                            backgroundColor: UIColors.black.withOpacity(0.6),
                            child: Icon(
                              Icons.star,
                              color: UIColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: UIColors.black,
                  ),
                  InkWell(
                    onTap: () {
                      _settingController.openEmailFeedback();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Help and assistence",
                              style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )),
                          CircleAvatar(
                            backgroundColor: UIColors.black.withOpacity(0.6),
                            child: Icon(
                              Icons.help,
                              color: UIColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: UIColors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Privacy policy",
                            style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                        CircleAvatar(
                          backgroundColor: UIColors.black.withOpacity(0.6),
                          child: Icon(
                            Icons.privacy_tip,
                            color: UIColors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _authController.logoutGoogle();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: UIColors.detailBlack,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Disconnetti account",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),
                      CircleAvatar(
                        backgroundColor: UIColors.black.withOpacity(0.6),
                        child: Icon(
                          Icons.exit_to_app_sharp,
                          color: Colors.red[500],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Cancella account',
                style: GoogleFonts.poppins(
                  color: theme.secondaryHeaderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                alignment: Alignment.center,
                child: Obx(() => Text(
                      _settingController.appCurrentVersion.value,
                      style: GoogleFonts.poppins(
                        color: theme.secondaryHeaderColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    )))
          ],
        )),
      ),
    );
  }

  Widget weeklySummary() {
    DateFormat formattedDate = DateFormat(
        Get.deviceLocale == "en" ? 'kk:mm  yyyy-MM-dd' : "kk:mm  dd-MM-yyyy");
    return Obx(
      () => statisticController.cookedMenus != null
          ? Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: statisticController.cookedMenus?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Card(
                          color: UIColors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  statisticController.cookedMenus![index].name,
                                  style: TextStyle(color: UIColors.black),
                                ),
                                subtitle: Text(formattedDate.format(
                                    statisticController
                                        .cookedMenus![index].cookedTime
                                        .toDate())),
                              ),
                            ],
                          ))
                    ],
                  );
                },
              ),
            )
          : SizedBox(),
    );
  }

  LineChartData mainData() {
    statisticController.getPoints();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          //reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.w400,
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Lun';
              case 2:
                return 'Mar';
              case 3:
                return 'Mer';
              case 4:
                return 'Gio';
              case 5:
                return 'Ven';
              case 6:
                return 'Sab';
              case 7:
                return 'Dom';
            }
            return '';
          },
          margin: 20,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 500:
                return '500';
              case 1500:
                return '1500';
              case 2500:
                return '2500';
              case 3500:
                return '3500';
            }
            return '';
          },
          reservedSize: 40,
          margin: 20,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1,
      maxX: 7,
      minY: 0,
      maxY: 4000,
      lineBarsData: [
        LineChartBarData(
          spots: statisticController.points,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
