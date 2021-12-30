import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/enum/dish_difficulty_enum.dart';

import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/menu_detail_bottom_sheet.dart';
import 'package:cached_network_image_builder/cached_network_image_builder.dart';

class MenuTile extends StatelessWidget {
  MenuTile(
      {Key? key,
      required this.menu,
      required this.ingredients,
      required this.savedMenu})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;
  final bool savedMenu;

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
                  ),
                  isScrollControlled: true)
            },
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.lowTransaprentWhite,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_rounded,
                              color: UIColors.black,
                            ),
                            Text(
                              " " +
                                  menu.preparationTime.toString() +
                                  "ESTIMATEDTIME".tr,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.insights_rounded,
                              color: Colors.black,
                            ),
                            Text(" " + menu.kcal.toString() + " kcal",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: UIColors.blue),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImageBuilder(
                          url: menu.linkUrl,
                          builder: (image) {
                            return Center(
                                child: Image.file(
                              image,
                              fit: BoxFit.cover,
                              height: mediaQuery.size.height * 0.25,
                              width: mediaQuery.size.width * 1,
                            ));
                          },
                          // Optional Placeholder widget until image loaded from url
                          placeHolder: LinearProgressIndicator(),
                          // Optional error widget
                          errorWidget:
                              Image.asset('assets/images/defaultMenu.jpeg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            menu.name +
                                " - " +
                                describeEnum(
                                        DishDifficulty.values[menu.difficulty])
                                    .toString()
                                    .tr +
                                " da cucinare.",
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
