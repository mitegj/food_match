import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/models/user_model.dart';

class DatabaseMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MenuModel>> menuStream() {
    return _firestore.collection("menu").snapshots().map((QuerySnapshot query) {
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
        .collection("users")
        .doc(uid)
        .collection("inventory")
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
          .collection("users")
          .doc(uid)
          .collection("inventory")
          .doc(idIngredient)
          .set({"id": idIngredient, "stock": stock});

      return true;
    } catch (e) {
      print(e);
      return false;
      // popup errore
    }
  }
}
