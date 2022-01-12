import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/home_body.dart';
import 'package:morning_brief/widgets/home/home_header.dart';
import 'package:package_info/package_info.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.isFirstLogin}) : super(key: key);
  final bool isFirstLogin;
  // essenziale non rimuovere
  // ignore: unused_field
  MenuController _menuController = Get.put<MenuController>(MenuController());

  Future<void> noResponsability() async {
    await PackageInfo.fromPlatform();
    if (isFirstLogin) {
      Get.defaultDialog(
          backgroundColor: UIColors.black,
          title: '\n' + 'NOTICE'.tr,
          titleStyle: TextStyle(color: UIColors.white),
          middleText: 'Se muori sono cazzi tuoi'.tr + '\n',
          middleTextStyle: TextStyle(color: UIColors.white),
          textConfirm: "OK",
          confirmTextColor: UIColors.white,
          buttonColor: UIColors.darkPurple,
          onConfirm: () {
            Get.back();
          },
          radius: 10.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    noResponsability();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
          child: Column(children: [
        HomeHeader(),
        //SizedBox(height: 10),
        HomeBody(
            // ingController: ingController,
            ),
      ])),
    );
  }
}
