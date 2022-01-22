import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/controllers/saved_menu_controller.dart';
import 'package:morning_brief/enum/dish_difficulty_enum.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/step_circle.dart';
import 'package:morning_brief/widgets/home/removed_menu.dart';
import 'package:morning_brief/widgets/home/step_screen.dart';

// ignore: must_be_immutable
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
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: Column(children: [
        Container(
            width: 60,
            child: Divider(height: 5, color: UIColors.black, thickness: 4)),
        const SizedBox(
          height: 30,
        ),
        Expanded(
            child: ListView(
          children: [
            Column(
              children: [
                Stack(
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
                            return Image.asset(
                                "assets/images/defaultMenu.jpeg");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    removeFromLaterButton(context)
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "IMAGEDISCLAIMER".tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const SizedBox(
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
                            child: const Icon(
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
                const SizedBox(height: 10),
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
                                    Text(getItemQty(item.qty) + item.unit + " ",
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
                    const SizedBox(
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
                startCookingButton(),
                cookedButton(),
                //saveForLaterButton(),
                //removeFromLaterButton(context),
              ],
            )
          ],
        )),
      ]),
    );
  }

  Widget startCookingButton() {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        Get.to(() => StepScreen(menu: menu));
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
          'STARTCOOKING'.tr,
          style: GoogleFonts.poppins(
              color: UIColors.detailBlack,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
    );
  }

  Widget cookedButton() {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        menuController.checkBeforeSaveMenu(menu, false);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: Text(
          'DISHCOOKED'.tr,
          style: GoogleFonts.poppins(
              color: UIColors.white, fontWeight: FontWeight.w500, fontSize: 16),
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
        : const SizedBox();
  }

  Widget removeFromLaterButton(BuildContext context) {
    return savedMenu
        ? InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
              Get.to(() => RemovedMenu(
                    context: context,
                  ));

              SavedMenuController.instance.removeSavedMenu(menu);
            },
            child: Icon(
              Icons.bookmark_remove,
              color: UIColors.white,
            ),
          )
        : InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
              menuController.updateSavedMenu(menu);
            },
            child: Icon(
              Icons.bookmark_add,
              color: UIColors.white,
            ),
          );
  }

  String getItemQty(int qty) {
    if (qty != 0) return qty.toString();
    return "";
  }
}
