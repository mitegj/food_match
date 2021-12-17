import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<List<MenuModel>> menuList = Rxn<List<MenuModel>>().obs();
  List<MenuModel>? get menus => menuList.value.obs();
  int limit = 30;
  set menus(List<MenuModel>? value) {
    menus?.clear();
  }

  IngredientController? _ingController;

  MenuController();
  MenuController.fromCtrl(IngredientController ingController)
      : _ingController = ingController;

  @override
  void onInit() {
    super.onInit();
    // getMenuList();
  }

  List<int> getAllFilters() {
    // se i filtri sono vuoti li aggiungo tutti
    List<int> fl = [];

    DishType.values.forEach((el) {
      fl.add(el.index);
    });

    return fl;
  }

  getMenuList(List<int> filters) {
    print(filters);
    if (filters.length == 0) {
      filters = getAllFilters();
    }
    menuList
        .bindStream(DatabaseMenu().menuStream(_ingController, filters, limit));
  }

  Future<void> updateStockCtrl(String uid, bool stock) async {
    try {
      if (await DatabaseMenu().updateInventory(uid, stock)) {
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

  Future<void> updateSavedMenu(String menuId) async {
    try {
      if (await DatabaseMenu().updateCookedMenu(menuId)) {
        //Get.back();
        Get.snackbar(
          "Ottimo lavoro",
          "Il tuo piatto è stato cucinato",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
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

  checkBeforeSaveMenu(MenuModel menu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastTimeCookedS = (prefs.getString('lastTimeCooked') ?? "");

    DateTime lastTimeCooked = DateTime.parse(lastTimeCookedS);
    double? lastCookingTime = prefs.getDouble('lastCookingTime');

    if (DateTime.now().difference(lastTimeCooked).inMinutes <
        lastCookingTime!) {
      Get.snackbar(
        "Ulala",
        "ulala il cuoco piu veloce del west",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      updateSavedMenu(menu.id).then(
        (_) => prefs.setDouble("lastCookingTime", menu.preparationTime).then(
            (_) =>
                prefs.setString('lastTimeCooked', DateTime.now().toString())),
      );
    }
  }

  String getIngredientName(String id, ingredients) {
    return ingredients!.where((el) => el.id == id).single.listName;
  }
}
