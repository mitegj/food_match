import 'package:cloud_firestore/cloud_firestore.dart';

class MenuIngredientModel {
  late String id;
  late int qty;
  late String unit;

  MenuIngredientModel({
    required this.id,
    required this.qty,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "qty": qty,
      "unit,": unit,
    };
  }

  factory MenuIngredientModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuIngredientModel(
      id: parsedJson['id'],
      qty: parsedJson['qty'],
      unit: parsedJson['unit'],
    );
  }

  MenuIngredientModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot["id"] ?? "";
    qty = documentSnapshot["qty"] ?? 0.0;
    unit = documentSnapshot["unit"] ?? "";
  }
}

extension MenuIngredientExtensions on QueryDocumentSnapshot {
  MenuIngredientModel get touser => MenuIngredientModel(
        id: this['id'],
        qty: this['qty'],
        unit: this['unit'],
      );
}
