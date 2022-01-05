import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/home/home_body.dart';
import 'package:morning_brief/widgets/home/home_header.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

// essenziale non rimuovere
  MenuController _menuController = Get.put<MenuController>(MenuController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

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
