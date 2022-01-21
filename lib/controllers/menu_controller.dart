import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/saved_menu_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:morning_brief/widgets/home/confirm_cooked.dart';
import 'package:morning_brief/widgets/home/reminder_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<List<MenuModel>> menuList = Rxn<List<MenuModel>>().obs();
  List<MenuModel>? get menus => menuList.value.obs();
  int limit = 30;
  RxBool hasOtherMenu = true.obs;
  set menus(List<MenuModel>? value) {
    menus?.clear();
  }

  RxList<int> getAllFilters() {
    // se i filtri sono vuoti li aggiungo tutti
    RxList<int> fl = RxList<int>();

    DishType.values.forEach((el) {
      fl.add(el.index);
    });

    return fl;
  }

  getMenuList(RxList<int> filters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int m = prefs.getInt("limitMultiplier") ?? 1;
    if (filters.length == 0) {
      filters = getAllFilters();
    }

    menuList.bindStream(DatabaseMenu().menuStream(filters, limit * m));
  }

  Future<void> updateStockCtrl(List<String> userInventory) async {
    try {
      if (await DatabaseMenu().updateInventory(userInventory)) {
        //Get.back();

      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateCookedMenu(MenuModel menu) async {
    try {
      if (await DatabaseMenu().updateCookedMenu(menu)) {
        Get.to(() => ConfirmCooked(
              cooked: true,
              fromStepsPage: false,
            ));
      }
    } catch (e) {
      Get.snackbar(
        "Error saving menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  checkBeforeSaveMenu(MenuModel menu, bool fromStepsPage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastTimeCookedS = "";
    int lastCookingTime = 0;
    (prefs.getString('lastTimeCooked') != null)
        ? lastTimeCookedS = prefs.getString('lastTimeCooked')!
        : lastTimeCookedS = DateTime(0).toString();
    prefs.getInt('lastCookingTime') != null
        ? lastCookingTime = prefs.getInt('lastCookingTime')!
        : lastCookingTime = 0;

    DateTime lastTimeCooked = DateTime.parse(lastTimeCookedS);
    if (DateTime.now().difference(lastTimeCooked).inMinutes < lastCookingTime) {
      Get.to(() => ConfirmCooked(
            cooked: false,
            fromStepsPage: fromStepsPage,
          ));
    } else {
      updateCookedMenu(menu).then(
        (_) => prefs.setInt("lastCookingTime", menu.preparationTime).then((_) =>
            prefs.setString('lastTimeCooked', DateTime.now().toString())),
      );

      SavedMenuController _menuController =
          Get.put<SavedMenuController>(SavedMenuController());
      _menuController.removeSavedMenu(menu);
    }
  }

  incrementLimitMultiplier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int m = prefs.getInt("limitMultiplier") ?? 1;
    prefs.setInt("limitMultiplier", ++m);
  }

  String getIngredientName(String id, ingredients) {
    var ing = ingredients!.where((el) => el.id == id);
    return (ing.length == 0)
        ? ""
        : ingredients!.where((el) => el.id == id).single.name;
  }

  Future<void> updateSavedMenu(MenuModel menu) async {
    try {
      await DatabaseMenu().saveMenuForLater(menu);
      Get.to(() => ReminderMenu());
    } catch (e) {
      Get.snackbar(
        "Error saving menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
