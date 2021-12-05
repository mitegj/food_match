import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';

class MenuController extends GetxController {
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<List<MenuModel>> menuList = Rxn<List<MenuModel>>().obs();
  List<MenuModel>? get menus => menuList.value.obs();

  @override
  void onInit() {
    super.onInit();
    menuList.bindStream(DatabaseMenu().menuStream());
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
}
