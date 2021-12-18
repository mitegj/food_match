import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/utils/UIColors.dart';

class FilterHeader extends StatelessWidget {
  FilterHeader({Key? key}) : super(key: key);

  static List<int> listFilters = [];
  List<Widget> getFilters() {
    MenuController _menuController = Get.put<MenuController>(MenuController());
    List<Widget> filters = [];
    DishType.values.forEach((el) {
      filters.add(Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10),
        child: InkWell(
          onTap: () => {
            (!listFilters.contains(el.index))
                ? listFilters.add(el.index)
                : listFilters.remove(el.index),
            //if (listFilters.length == 0) listFilters.add(-1),
            _menuController.getMenuList(listFilters)
          },
          child: Container(
            margin: EdgeInsets.all(20),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: listFilters.contains(el.index)
                    ? UIColors.darkPurple
                    : UIColors.detailBlack,
                borderRadius: BorderRadius.circular(20)),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.local_pizza,
                    color: UIColors.white,
                    size: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      el.name.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: GridView.count(
          crossAxisCount: 2,
          children: getFilters(),
        ));
  }
}
