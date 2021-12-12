import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/filters_header.dart';
import 'package:morning_brief/widgets/home/home_header.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class HomePage extends GetWidget<IngredientController> {
  HomePage({Key? key}) : super(key: key);
  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    MenuController _menuController =
        Get.put<MenuController>(MenuController.fromCtrl(ingController));
    _menuController.menus = [];
    _menuController.getMenuList(_menuController.getAllFilters());

    return Obx(() => (ingController.userAllergies != null &&
            ingController.ingredients != null)
        ? (_menuController.menus != null)
            ? Scaffold(
                backgroundColor: theme.backgroundColor,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                    child: Column(children: [
                  HomeHeader(),
                  FilterHeader(),
                  Expanded(
                      child: _menuController.menus?.length == 0
                          ? EmptyMenu()
                          : ListView.builder(
                              itemCount: _menuController.menus?.length ?? 0,
                              itemBuilder: (_, index) {
                                return Obx(() => MenuTile(
                                    menu: _menuController.menus![index],
                                    ingredients: ingController.ingredients));
                              },
                            )),
                ])),
              )
            : LoadingWidget()
        : LoadingWidget());
  }
}
