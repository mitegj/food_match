import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

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
      "name" + conf.lang: listName,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> parsedJson) {
    return IngredientModel(
        id: parsedJson['id'], listName: parsedJson['name' + conf.lang]);
  }

  IngredientModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    listName = documentSnapshot["name" + conf.lang] ?? "";
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  IngredientModel get toIngredient => IngredientModel(
        id: this.id,
        listName: this['name' + conf.lang],
      );
}
