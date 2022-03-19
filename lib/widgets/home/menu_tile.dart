import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/enum/dish_difficulty_enum.dart';

import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/menu_detail_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class MenuTile extends StatelessWidget {
  MenuTile(
      {Key? key,
      required this.menu,
      required this.ingredients,
      required this.savedMenu,
      required this.isCookable})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;
  final bool savedMenu;
  final bool isCookable;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return InkWell(
        onTap: () => {
              Get.bottomSheet(
                  DetailBottomSheet(
                      menu: menu,
                      ingredients: ingredients,
                      savedMenu: savedMenu,
                      isCookable: isCookable),
                  isScrollControlled: true)
            },
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.lowTransaprentWhite,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    UIColors.violet.withOpacity(0.2),
                                child: Icon(
                                  Icons.access_time_filled_rounded,
                                  color: UIColors.violet,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Text(
                                  " " +
                                      menu.preparationTime.toString() +
                                      " " +
                                      "ESTIMATEDTIME".tr.toLowerCase(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    UIColors.violet.withOpacity(0.2),
                                child: Icon(
                                  Icons.insights_rounded,
                                  color: UIColors.violet,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Text(
                                    " " + menu.kcal.toString() + " kcal",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: RichText(
                            text: TextSpan(
                                text: menu.name,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: " - " +
                                        describeEnum(DishDifficulty
                                                .values[menu.difficulty])
                                            .toString()
                                            .tr +
                                        "TOCOOK".tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  ),
                                ]),
                          )),
                        ],
                      ),
                    ),
                    !isCookable
                        ? const SizedBox(height: 5)
                        : const SizedBox(height: 0),
                    !isCookable
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 7.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.red.withOpacity(0.1),
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red[500],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "MISSINGINGREDIENTSLABEL"
                                            .tr
                                            .toLowerCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        height: mediaQuery.size.height * 0.35,
                        width: mediaQuery.size.height * 1,
                        imageUrl: menu.linkUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            LoadingWidgetSquareCircle(),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/defaultMenu.jpeg"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
