import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:morning_brief/widgets/home/removed_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedMenuController extends MenuController {
  static SavedMenuController instance = Get.find();

  getMenuList(RxList<int> filters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int m = prefs.getInt("limitMultiplier") ?? 1;
    if (filters.length == 0) {
      filters = getAllFilters();
    }

    menuList.bindStream(DatabaseMenu().savedMenuStream(limit * m));
  }

  Future<void> removeSavedMenu(MenuModel menu) async {
    try {
      await DatabaseMenu().removeMenuFromLater(menu);
      /*Get.snackbar(
        "PERFECT".tr,
        "MENUREMOVEDCORRECTLY".tr,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );*/
    } catch (e) {
      Get.snackbar(
        "Error removing menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
