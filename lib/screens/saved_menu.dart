import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/controllers/saved_menu_controller%20copy.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/filters_body.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class SavedMenuPage extends GetWidget<MenuController> {
  SavedMenuPage({Key? key}) : super(key: key);

  IngredientController ingController = IngredientController.instance;
  @override
  Widget build(BuildContext context) {
    SavedMenuController _menuController =
        Get.put<SavedMenuController>(SavedMenuController());
    _menuController.getMenuList(FilterBody.listFilters);
    return Expanded(
      child: Container(
          child: Obx(() => (ingController.userAllergies != null &&
                  ingController.ingredients != null)
              ? (_menuController.menus != null &&
                      _menuController.menus?.length == 0)
                  ? EmptyMenu()
                  : ListView(
                      children: <Widget>[
                        ListView.builder(
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
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => {
                                _menuController.incrementLimitMultiplier(),
                                _menuController
                                    .getMenuList(FilterBody.listFilters)
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: UIColors.detailBlack,
                                ),
                                child: TextButton(
                                  onPressed: null,
                                  child: Text("LOADOTHERMENU".tr,
                                      style: GoogleFonts.poppins(
                                          color: UIColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )
              : LoadingWidget())),
    );
  }
}
