import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
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
                  SizedBox(height: 10),
                  FilterHeader(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 30.0),
                    child: Row(
                      children: [
                        Text("Piatti consigliati",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Text("Scorri per visualizzare altre ricette",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                  Container(
                      height: 8,
                      width: 370,
                      decoration: BoxDecoration(
                          color: UIColors.detailBlack.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
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
                  InkWell(
                      onTap: () => {
                            _menuController.limit += 1,
                            _menuController
                                .getMenuList(FilterHeader.listFilters)
                          },
                      child: Text("Carica altri elementi"))
                ])),
              )
            : LoadingWidget()
        : LoadingWidget());
  }
}
