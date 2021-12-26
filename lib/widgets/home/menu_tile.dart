import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                height: mediaQuery.size.height * 0.20,
                width: mediaQuery.size.width * 0.30,
                margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    menu.linkUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: BoxDecoration(
                    color: UIColors.violet,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)))),
            Container(
                height: mediaQuery.size.height * 0.20,
                width: mediaQuery.size.width * 0.57,
                margin: EdgeInsets.only(top: 20, bottom: 0, left: 10),
                decoration: BoxDecoration(
                    color: UIColors.detailBlack,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "ESTIMATEDTIME".tr,
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
                              menu.name.toString(),
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
                                  fontSize: 15),
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
