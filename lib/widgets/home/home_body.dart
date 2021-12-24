import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
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
    _menuController.getMenuList(FilterHeader.listFilters);

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
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 250,
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Column(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 15),
                                              margin: EdgeInsets.only(
                                                  bottom: 30, top: 25),
                                              height:
                                                  mediaQuery.size.height * 0.15,
                                              width:
                                                  mediaQuery.size.width * 0.7,
                                              decoration: BoxDecoration(
                                                  color: UIColors.detailBlack,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Resoconto settimanale",
                                                        style: TextStyle(
                                                            color:
                                                                UIColors.pink,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Piatto preferito",
                                                        style: TextStyle(
                                                          color: UIColors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Nome del piatto",
                                                        style: TextStyle(
                                                          color: UIColors.white
                                                              .withOpacity(0.6),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Piatti cucinati",
                                                        style: TextStyle(
                                                          color: UIColors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Numero di piatti",
                                                        style: TextStyle(
                                                          color: UIColors.white
                                                              .withOpacity(0.6),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          right: 20,
                                          top: 0,
                                          child: Container(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                'assets/images/home.png',
                                                scale: 1.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'DAILY_RECEPY'.tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'SCROLLFORMORE'.tr,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withOpacity(0.6)),
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
                          height: 50,
                        ),
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
                    )
              : LoadingWidget())),
    );
  }
}
