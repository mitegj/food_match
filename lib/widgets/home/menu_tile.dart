import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/menu_detail_bottom_sheet.dart';

class MenuTile extends StatelessWidget {
  MenuTile({Key? key, required this.menu, required this.ingredients})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);


    return InkWell(
        onTap: () => {
              Get.bottomSheet(
                  DetailBottomSheet(
                    menu: menu,
                    ingredients: ingredients,
                  ),
                  isScrollControlled: true)
            },
        child: Row(
          children: [
            Container(
                height: mediaQuery.size.height * 0.15,
                width: mediaQuery.size.width * 0.30,
                margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
                decoration: BoxDecoration(
                  color: UIColors.violet,
                )),
            Container(
                height: mediaQuery.size.height * 0.15,
                width: mediaQuery.size.width * 0.57,
                margin: EdgeInsets.only(top: 20, bottom: 0, left: 10),
                decoration: BoxDecoration(color: UIColors.detailBlack),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Tempo stimato",
                            style: TextStyle(
                                color: UIColors.pink,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              menu.menuName.toString(),
                              style: TextStyle(
                                  color: UIColors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Descrizione da sistemare",
                              style: TextStyle(
                                  color: UIColors.white.withOpacity(0.8),
                                fontSize: 15
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
