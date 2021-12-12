import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';

class FilterHeader extends StatelessWidget {
  FilterHeader({Key? key}) : super(key: key);

  static List<int> listFilters = [];

  List<Widget> getFilters() {
    MenuController _menuController = Get.put<MenuController>(MenuController());
    List<Widget> filters = [];
    DishType.values.forEach((el) {
      filters.add(TextButton(
          onPressed: () => {
                (!listFilters.contains(el.index))
                    ? listFilters.add(el.index)
                    : listFilters.remove(el.index),
                //if (listFilters.length == 0) listFilters.add(-1),
                _menuController.getMenuList(listFilters)
              },
          child: Text(
            describeEnum(el),
            style: TextStyle(
                color: listFilters.contains(el.index)
                    ? Colors.blue
                    : Colors.white),
          )));
    });
    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getFilters(),
    );
  }
}
