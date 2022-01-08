import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/setting_controller.dart';
import 'package:morning_brief/controllers/statistic_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:intl/intl.dart';
import 'package:morning_brief/widgets/settings/delete_account_button.dart';
import 'package:morning_brief/widgets/settings/disconnect_account_button.dart';
import 'package:morning_brief/widgets/settings/info_version.dart';
import 'package:morning_brief/widgets/settings/settings_area.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class StatisticsScreen extends GetWidget<AllergyController> {
  StatisticsScreen({Key? key}) : super(key: key);
  List<Color> gradientColors = [
    UIColors.lightRed,
    UIColors.blue,
    UIColors.darkPurple,
  ];

  RxBool visibility = false.obs;

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
    DateFormat formattedDate = DateFormat(Get.deviceLocale.toString() == "en"
        ? 'kk:mm  yyyy-MM-dd'
        : "kk:mm  dd-MM-yyyy");
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: UIColors.blue,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    _settingController.getUserInitial(),
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("WEEKLYCAL".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 18,
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
              padding: const EdgeInsets.all(20.0),
              child: Text("WEEKLYHISTORY".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: InkWell(
                onTap: () => {visibility.value = !visibility.value},
                child: Container(
                  width: mediaQuery.size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Obx(
                          () => Icon(
                            visibility.value
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text("SHOW".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: UIColors.detailBlack,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Obx(
                  () => statisticController.cookedMenus != null
                      ? Visibility(
                          visible: visibility.value,
                          child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  statisticController.cookedMenus?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, top: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        statisticController
                                                            .cookedMenus![index]
                                                            .name
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: UIColors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        formattedDate.format(
                                                            statisticController
                                                                .cookedMenus![
                                                                    index]
                                                                .cookedTime
                                                                .toDate()),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: UIColors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (index !=
                                            (statisticController
                                                    .cookedMenus?.length)! -
                                                1)
                                          Divider(
                                            color: UIColors.black,
                                          )
                                      ],
                                    ));
                              }),
                        )
                      : LoadingWidget(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("SETTINGS".tr,
                  style: GoogleFonts.poppins(
                      color: UIColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
            settingsArea(settingController: _settingController),
            disconnectAccountButton(authController: _authController),
            const SizedBox(height: 40),
            deleteAccount(authController: _authController, theme: theme),
            const SizedBox(height: 40),
            infoVersion(settingController: _settingController, theme: theme),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget weeklySummary() {
    DateFormat formattedDate = DateFormat(Get.deviceLocale.toString() == "en"
        ? 'kk:mm  yyyy-MM-dd'
        : "kk:mm  dd-MM-yyyy");
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
          : LoadingWidget(),
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
                return 'MON'.tr;
              case 2:
                return 'TUE'.tr;
              case 3:
                return 'WED'.tr;
              case 4:
                return 'THE'.tr;
              case 5:
                return 'FRI'.tr;
              case 6:
                return 'SAT'.tr;
              case 7:
                return 'SUN'.tr;
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
              case 1000:
                return '1000';
              case 1500:
                return '1500';
              case 2000:
                return '2000';
              case 2500:
                return '2500';
              /*case 3500:
                return '3500';*/
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
      maxY: 3000,
      lineBarsData: [
        LineChartBarData(
          isStepLineChart: false,
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
