import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/controllers/saved_menu_controller.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';

import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/saved/empty_saved_menu.dart';
import 'package:morning_brief/widgets/saved/saved_header.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class SavedMenuPage extends GetWidget<MenuController> {
  SavedMenuPage({Key? key}) : super(key: key);

  IngredientController ingController = IngredientController.instance;
  @override
  Widget build(BuildContext context) {
    SavedMenuController _menuController =
        Get.put<SavedMenuController>(SavedMenuController());
    _menuController.getMenuList(FilterBody.listFilters);
    return Column(
      children: [
        SavedHeader(),
        Expanded(
            child: Obx(() => (ingController.userAllergies != null &&
                    ingController.ingredients != null)
                ? (_menuController.menus != null &&
                        _menuController.menus?.length == 0)
                    ? EmptySavedMenu()
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _menuController.menus?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Obx(() => MenuTile(
                                    ingredients: ingController.ingredients,
                                    menu: _menuController.menus![index],
                                    savedMenu: true,
                                  )));
                        })
                : LoadingWidget())),
      ],
    );
  }
}
