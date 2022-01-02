import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseIngredient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Stream<List<IngredientModel>> ingredientStream() {
    try {
      return _firestore
          .collection(conf.inventoryListCollection)
          .snapshots()
          .map((QuerySnapshot query) {
        List<IngredientModel> retVal = [];
        for (var element in query.docs) {
          retVal.add(IngredientModel.fromDocumentSnapshot(element));
        }
        retVal.sort((a, b) => a.name.compareTo(b.name));
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting ingredients",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }
}
