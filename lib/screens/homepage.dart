import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/home/card_tile.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/home_header.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class HomePage extends GetWidget<IngredientController> {
  HomePage({Key? key}) : super(key: key);

  IngredientController _ingController =
      Get.put<IngredientController>(IngredientController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Obx(() => GetX<IngredientController>(
        init: Get.put<IngredientController>(IngredientController()),
        builder: (IngredientController ingController) {
          if (ingController.userAllergies != null &&
              ingController.ingredients != null) {
            return GetX<MenuController>(
              init: Get.put<MenuController>(
                  MenuController.fromCtrl(ingController)),
              builder: (MenuController menuController) {
                if (menuController.menus != null) {
                  return Scaffold(
                    backgroundColor: theme.backgroundColor,
                    resizeToAvoidBottomInset: true,
                    body: SafeArea(
                        child: Column(children: [
                      HomeHeader(),
                      Expanded(
                          child: menuController.menus?.length == 0
                              ? EmptyMenu()
                              : ListView.builder(
                                  itemCount: menuController.menus?.length ?? 0,
                                  itemBuilder: (_, index) {
                                    return Obx(() => MenuTile(
                                        menu: menuController.menus![index],
                                        ingredients:
                                            _ingController.ingredients));
                                  },
                                )),
                    ])),
                  );
                } else {
                  return LoadingWidget();
                }
              },
            );
          } else {
            return LoadingWidget();
          }
        }));
  }
}
