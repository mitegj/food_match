import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:morning_brief/widgets/filter/filters.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Stream<List<MenuModel>> menuStream(List<int> filters, int limit) {
    try {
      IngredientController _ingController;
      AllergyController _allergyController;

      MenuController _menuController;
      try {
        _ingController = IngredientController.instance;
      } catch (e) {
        _ingController = Get.put<IngredientController>(IngredientController());
      }

      try {
        _allergyController = AllergyController.instance;
      } catch (e) {
        _allergyController = Get.put<AllergyController>(AllergyController());
      }

      try {
        _menuController = MenuController.instance;
      } catch (e) {
        _menuController = Get.put<MenuController>(MenuController());
      }
      //userIngredientList.bindStream(DatabaseMenu().userInventoryStream());

      //userAllergyList.bindStream(DatabaseAllergy().userAllergiesStream());
      return _firestore
          .collection(conf.menuCollection)
          .where("dishType", whereIn: filters)
          .orderBy("insertionDate", descending: true)
          .limit(limit)
          .snapshots()
          .map((QuerySnapshot query) {
        List<MenuModel> retVal = [];
        for (var element in query.docs) {
          MenuModel menu = MenuModel.fromDocumentSnapshot(element);

          if (!_menuController.isUserAllergic(menu, _allergyController.userAllergies ?? [])) {
            if (FiltersPage.getAllMenus.value ||
                _menuController.userHasIngredients(
                    menu, _ingController.userIngredients ?? [])) {
              retVal.add(menu);
            }
          }
        }
        _menuController.hasOtherMenu(retVal.length);
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting menus",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }


  Stream<List<MenuModel>> savedMenuStream(int limit) {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      return _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.savedMenuCollection)
          .orderBy("insertionDate", descending: true)
          .limit(limit)
          .snapshots()
          .map((QuerySnapshot query) {
        List<MenuModel> retVal = [];
        for (var element in query.docs) {
          MenuModel menu = MenuModel.fromDocumentSnapshot(element);
          retVal.add(menu);
        }
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting saved menus",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }

  Stream<List<String>> userInventoryStream() {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();

      return _firestore
          .collection(conf.userCollection)
          .where('id', isEqualTo: uid)
          //.doc(uid)
          // prendere solamente quelli a true?
          //.collection(conf.inventoryCollection)
          .snapshots()
          .map((QuerySnapshot query) {
        List<String> retVal = [];
        for (var element in query.docs) {
          element['ingredients'].forEach((el) => {retVal.add(el.toString())});
        }
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting user inventory",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }

  Future<bool> updateInventory(List<String> userInventory) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      await FirebaseFirestore.instance.collection(conf.userCollection).doc(uid)
          //.collection(conf.inventoryCollection)
          //.doc(idIngredient)
          .update({"ingredients": userInventory});

      return true;
    } catch (e) {
      Get.snackbar(
        "Error updating inventory",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> updateCookedMenu(MenuModel menu) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      List<String> menus = [];
      menus.add(menu.id);
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.cookedMenuCollection)
          .doc()
          .set(menu.toCookedMap());

      return true;
    } catch (e) {
      Get.snackbar(
        "Error updating cooked menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
      // popup errore
    }
  }

  Future<void> saveMenuForLater(MenuModel menu) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.savedMenuCollection)
          .doc(menu.id)
          .set(menu.toMap());
    } catch (e) {
      Get.snackbar(
        "Error saving menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> removeMenuFromLater(MenuModel menu) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.savedMenuCollection)
          .doc(menu.id)
          .delete();
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
