import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:morning_brief/widgets/home/confirm_cooked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

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

  RxList<int> getAllFilters() {
    // se i filtri sono vuoti li aggiungo tutti
    RxList<int> fl = RxList<int>();

    DishType.values.forEach((el) {
      fl.add(el.index);
    });

    return fl;
  }

  getMenuList(RxList<int> filters) {
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

  Future<void> updateSavedMenu(MenuModel menu) async {
    try {
      if (await DatabaseMenu().updateCookedMenu(menu)) {
        Get.to(() => ConfirmCooked(
              cooked: true,
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

  checkBeforeSaveMenu(MenuModel menu) async {
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
      Get.to(() => ConfirmCooked(cooked: false));
    } else {
      updateSavedMenu(menu).then(
        (_) => prefs.setInt("lastCookingTime", menu.preparationTime).then((_) =>
            prefs.setString('lastTimeCooked', DateTime.now().toString())),
      );
    }
  }

  String getIngredientName(String id, ingredients) {
    var ing = ingredients!.where((el) => el.id == id);
    return (ing.length == 0)
        ? ""
        : ingredients!.where((el) => el.id == id).single.name;
  }
}
