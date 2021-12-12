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
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: listFilters.contains(el.index)
                  ? UIColors.violet
                  : UIColors.detailBlack,
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
              onPressed: () => {
                    (!listFilters.contains(el.index))
                        ? listFilters.add(el.index)
                        : listFilters.remove(el.index),
                    //if (listFilters.length == 0) listFilters.add(-1),
                    _menuController.getMenuList(listFilters)
                  },
              child: Text(
                describeEnum(el),
                style: TextStyle(color: Colors.white),
              )),
        ),
      ));
    });
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: getFilters(),
      ),
    );
  }
}
