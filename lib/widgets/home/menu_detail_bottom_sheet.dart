import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/enum/dish_difficulty_enum.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/step_circle.dart';

class DetailBottomSheet extends StatelessWidget {
  DetailBottomSheet(
      {Key? key,
      required this.menu,
      required this.ingredients,
      required this.savedMenu})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;
  final bool savedMenu;

  MenuController menuController = Get.put<MenuController>(MenuController());

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.85,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: Column(children: [
        Container(
            width: 60,
            child: Divider(height: 5, color: UIColors.black, thickness: 4)),
        SizedBox(
          height: 30,
        ),
        Expanded(
            child: ListView(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: UIColors.black,
                    ),
                    child: Image.network(
                      menu.linkUrl,
                      fit: BoxFit.cover,
                      height: mediaQuery.size.height * 0.25,
                      width: mediaQuery.size.width * 1,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/defaultMenu.jpeg");
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      describeEnum(DishType.values[menu.dishType])
                          .toString()
                          .tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.pink,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        menu.name.toString(),
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.poppins(
                            color: UIColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: mediaQuery.size.width,
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: UIColors.black,
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.access_time_filled_rounded,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            menu.preparationTime.toString() + " min",
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.emoji_events_rounded,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            describeEnum(DishDifficulty.values[menu.difficulty])
                                .toString()
                                .tr,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.insights_rounded,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            menu.kcal.toString() + " kcal",
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: mediaQuery.size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: UIColors.black,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(15.0),
                          topRight: const Radius.circular(15.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("INGREDIENTSLIST".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: mediaQuery.size.width,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 0),
                  decoration: BoxDecoration(
                      color: UIColors.black,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(15.0),
                          bottomRight: const Radius.circular(15.0))),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          for (var item in menu.ingredients)
                            IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        menuController.getIngredientName(
                                            item!.id.toString(), ingredients),
                                        style: GoogleFonts.poppins(
                                            color: UIColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    Text(item.qty.toString() + item.unit + " ",
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                            color: UIColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          menu.note,
                          style: GoogleFonts.poppins(
                              color: UIColors.pink,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "METHOD".tr,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (var item in menu.steps)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StepCircle(indice: menu.steps.indexOf(item) + 1),
                            Expanded(
                              child: Text(item,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                      color: UIColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                cookedButton(),
                saveForLaterButton(),
                removeFromLaterButton(context),
              ],
            )
          ],
        )),
      ]),
    );
  }

  Widget cookedButton() {
    return InkWell(
      onTap: () {
        menuController.checkBeforeSaveMenu(menu, savedMenu);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'DISHCOOKED'.tr,
          style: GoogleFonts.poppins(
              color: UIColors.detailBlack,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
      ),
    );
  }

  Widget saveForLaterButton() {
    return !savedMenu
        ? InkWell(
            onTap: () {
              menuController.updateSavedMenu(menu);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                'SAVEMENUFORLATER'.tr,
                style: GoogleFonts.poppins(
                    color: UIColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          )
        : SizedBox();
  }

  Widget removeFromLaterButton(BuildContext context) {
    return savedMenu
        ? InkWell(
            onTap: () {
              Navigator.pop(context);
              menuController.removeSavedMenu(menu);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
              child: Text(
                'REMOVEFROMLATER'.tr,
                style: GoogleFonts.poppins(
                    color: UIColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          )
        : SizedBox();
  }
}
