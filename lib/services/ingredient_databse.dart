import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/models/ingredient_model.dart';

class DatabaseIngredient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<IngredientModel>> ingredientStream() {
    return _firestore
        .collection("inventoryList")
        .snapshots()
        .map((QuerySnapshot query) {
      List<IngredientModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(IngredientModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }
}
