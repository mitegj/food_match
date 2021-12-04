import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/home/card_tile.dart';
import 'package:morning_brief/widgets/home/home_header.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Obx(() => GetX<MenuController>(
          init: Get.put<MenuController>(MenuController()),
          builder: (MenuController menuController) {
            if (menuController.menus != null) {
              return Scaffold(
                backgroundColor: theme.backgroundColor,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                    child: Column(children: [
                  HomeHeader(),
                  Expanded(
                      child: ListView.builder(
                    itemCount: menuController.menus?.length ?? 0,
                    itemBuilder: (_, index) {
                      return Obx(
                          () => CardTile(menu: menuController.menus![index]));
                    },
                  )),
                ])),
              );
            } else {
              return LoadingWidget();
            }
          },
        ));
  }
}
