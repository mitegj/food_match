import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/filters.dart';
import 'package:morning_brief/widgets/home/filters_body.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';
import 'filters_body.dart';

class HomeBody extends GetWidget<IngredientController> {
  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    MenuController _menuController =
        Get.put<MenuController>(MenuController.fromCtrl(ingController));
    _menuController.menus = [];
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            // height: 250,
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SCROLLFORMORE'.tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.6)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => FiltersPage());
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            Icons.filter_alt_outlined,
                                            color: UIColors.white,
                                          ),
                                          FilterBody.listFilters.length > 0
                                              ? Positioned(
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        UIColors.violetMain,
                                                  ),
                                                  top: -5,
                                                  right: -10,
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                        ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _menuController.menus?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: Obx(() => MenuTile(
                                        ingredients: ingController.ingredients,
                                        menu: _menuController.menus![index],
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
