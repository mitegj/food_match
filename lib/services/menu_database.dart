import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  bool isUserAllergic(MenuModel menu, IngredientController? _ingController) {
    bool isUserAllergic = false;
    menu.allergies.forEach((al) {
      if (_ingController?.userAllergies?.contains(al) ?? false)
        isUserAllergic = true;
    });

    return isUserAllergic;
  }

  bool userHasIngredients(
      MenuModel menu, IngredientController? _ingController) {
    bool hasUserIngredients = false;
    List<String> userIngredients = getUserIngredientsList(_ingController);

    for (MenuIngredientModel? ing in menu.ingredients) {
      if (userIngredients.contains(ing?.id)) {
        hasUserIngredients = true;
      } else {
        hasUserIngredients = false;
        break;
      }
    }
    return hasUserIngredients;
  }

  List<String> getUserIngredientsList(IngredientController? _ingController) {
    List<String> ing = [];
    _ingController?.userIngredients?.forEach((UserInventory el) {
      if (el.stock) {
        ing.add(el.id);
      }
    });
    return ing;
  }

  Stream<List<MenuModel>> menuStream(
      IngredientController? _ingController, List<int> filters, int limit) {
    try {
      return _firestore
          .collection(conf.menuCollection)
          .where("dishType", whereIn: filters)
          .limit(limit)
          .snapshots()
          .map((QuerySnapshot query) {
        List<MenuModel> retVal = [];
        for (var element in query.docs) {
          MenuModel menu = MenuModel.fromDocumentSnapshot(element);
          if (!isUserAllergic(menu, _ingController)) {
            if (userHasIngredients(menu, _ingController)) {
              retVal.add(menu);
            }
          }
        }
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

  Stream<List<UserInventory>> userInventoryStream() {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      return _firestore
          .collection(conf.userCollection)
          .doc(uid)
          // prendere solamente quelli a true?
          .collection(conf.inventoryCollection)
          .snapshots()
          .map((QuerySnapshot query) {
        List<UserInventory> retVal = [];
        for (var element in query.docs) {
          retVal.add(UserInventory.fromDocumentSnapshot(element));
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

  Future<bool> updateInventory(String idIngredient, bool stock) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.inventoryCollection)
          .doc(idIngredient)
          .set({"id": idIngredient, "stock": stock});

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
          .set({
        "id": menu.id,
        "name": menu.menuName,
        "kcal": menu.kcal,
        "dishType": menu.dishType,
        "preparationTime": menu.preparationTime,
        "cookedTime": DateTime.now()
      });

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
}
