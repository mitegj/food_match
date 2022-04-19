import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/global_input/tutorial.dart';
import 'package:morning_brief/widgets/home/home_body.dart';
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
      Get.bottomSheet(Tutorial(), isScrollControlled: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    noResponsability();
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
          child: HomeBody(
              // ingController: ingController,
              )),
    );
  }
}
