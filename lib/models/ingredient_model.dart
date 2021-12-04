import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientModel {
  late String id;
  late String listName;
  IngredientModel({
    required this.id,
    required this.listName,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "listName": listName,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> parsedJson) {
    return IngredientModel(
        id: parsedJson['id'], listName: parsedJson['listName']);
  }

  IngredientModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    listName = documentSnapshot["listName"] ?? "";
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  IngredientModel get toIngredient => IngredientModel(
        id: this.id,
        listName: this['listName'],
      );
}
