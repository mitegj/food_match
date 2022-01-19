import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class IngredientModel {
  late String id;
  late String name;
  IngredientModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name" + conf.lang: name,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> parsedJson) {
    return IngredientModel(
        id: parsedJson['id'], name: parsedJson['name' + conf.lang]);
  }

  IngredientModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = conf.docContains("name" + conf.lang, documentSnapshot)
        ? documentSnapshot["name" + conf.lang]
        : "";
  }

  IngredientModel.fromListDocumentSnapshot(
    var obj,
  ) {
    id = obj['id'];
    name = obj["name" + conf.lang];
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  IngredientModel get toIngredient => IngredientModel(
        id: this.id,
        name: this['name' + conf.lang],
      );
}
