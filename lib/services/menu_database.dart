import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Stream<List<MenuModel>> menuStream() {
    return _firestore
        .collection(conf.menuCollection)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MenuModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(MenuModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Stream<List<UserInventory>> userInventoryStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    return _firestore
        .collection(conf.userCollection)
        .doc(uid)
        .collection(conf.inventoryCollection)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserInventory> retVal = [];
      for (var element in query.docs) {
        retVal.add(UserInventory.fromDocumentSnapshot(element));
      }
      return retVal;
    });
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
      print(e);
      return false;
      // popup errore
    }
  }

  Future<bool> updateCookedMenu(String menuId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      List<String> menus = [];
      menus.add(menuId);
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.cookedMenuCollection)
          .doc(menuId)
          .set({"id": menuId, "cookedTime": DateTime.now()});

      return true;
    } catch (e) {
      print(e);
      return false;
      // popup errore
    }
  }
}
