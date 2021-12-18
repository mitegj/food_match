import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/filters_header.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class HomeBody extends GetWidget<IngredientController> {
  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    MenuController _menuController =
        Get.put<MenuController>(MenuController.fromCtrl(ingController));
    _menuController.menus = [];
    _menuController.getMenuList(_menuController.getAllFilters());

    return Container(
      height: mediaQuery.size.height * 0.7,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 60,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Le nostre proposte',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      'Scorri per visualizzare altre ricette',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => (ingController.userAllergies != null &&
                  ingController.ingredients != null)
              ? (_menuController.menus != null)
                  ? ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _menuController.menus?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            height: 200,
                            child: _menuController.menus?.length == 0
                                ? EmptyMenu()
                                : Obx(() => MenuTile(
                                      ingredients: ingController.ingredients,
                                      menu: _menuController.menus![index],
                                    )));
                      })
                  : LoadingWidget()
              : LoadingWidget()),
          Container(
            height: 40,
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
    );
  }
}
