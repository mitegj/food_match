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
      child: Container(
          width: mediaQuery.size.width * 1,
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          margin:
              const EdgeInsets.only(bottom: 20, top: 0, left: 20, right: 20),
          decoration: BoxDecoration(
              color: UIColors.detailBlack,
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: mediaQuery.size.width * 0.7,
                decoration: BoxDecoration(
                    color: UIColors.orange,
                    borderRadius: BorderRadius.circular(50)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                    fit: BoxFit.cover,
                    height: mediaQuery.size.height * 1,
                    width: mediaQuery.size.width * 1,
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
                      menu.menuName.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    describeEnum(DishType.values[menu.dishType]),
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "- " + menu.preparationTime.toString() + " minutes",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  )
                ],
              )
            ],
          )),
    );
  }
}
