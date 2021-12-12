import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';

class MenuController extends GetxController {
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<List<MenuModel>> menuList = Rxn<List<MenuModel>>().obs();
  List<MenuModel>? get menus => menuList.value.obs();
  set menus(List<MenuModel>? value) {
    menus?.clear();
  }

  IngredientController? _ingController;

  MenuController();
  MenuController.fromCtrl(IngredientController ingController)
      : _ingController = ingController {
    this.onInit();
  }

  @override
  void onInit() {
    super.onInit();
    getMenuList();
  }

  getMenuList() {
    menuList.bindStream(DatabaseMenu().menuStream(_ingController, 30));
  }

  Future<bool> updateStockCtrl(String uid, bool stock) async {
    try {
      if (await DatabaseMenu().updateInventory(uid, stock)) {
        //Get.back();
        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return false;
  }

  Future<bool> updateSavedMenu(String menuId) async {
    try {
      if (await DatabaseMenu().updateCookedMenu(menuId)) {
        //Get.back();
        Get.snackbar(
          "Ottimo lavoro",
          "Il tuo piatto è stato cucinato",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error saving menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return false;
  }

  String getIngredientName(String id, ingredients) {
    return ingredients!.where((el) => el.id == id).single.listName;
  }
}
