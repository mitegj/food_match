import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';

class MenuModel {
  late String id;
  late String menuName;
  late int kcal;
  late double difficulty;
  late double preparationTime;
  late List<String> allergies;
  late List<String> steps;
  late List<MenuIngredientModel?> ingredients;
  late String note;
  late String desc;
  late int dishType;

  MenuModel(
      {required this.id,
      required this.menuName,
      required this.kcal,
      required this.difficulty,
      required this.preparationTime,
      required this.allergies,
      required this.steps,
      required this.ingredients,
      required this.note,
      required this.desc,
      required this.dishType});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "menuName": menuName,
      "kcal": kcal,
      "difficulty,": difficulty,
      "preparationTime": preparationTime,
      "allergies": allergies,
      "steps": steps,
      "ingredients": ingredients,
      "note": note,
      "desc": desc,
      "dishType": dishType
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuModel(
        id: parsedJson["id"],
        menuName: parsedJson['menuName'],
        kcal: parsedJson['kcal'],
        difficulty: parsedJson['difficulty'],
        preparationTime: parsedJson['preparationTime'],
        allergies: parsedJson['allergies'],
        steps: parsedJson['steps'],
        ingredients: parsedJson['ingredients'],
        note: parsedJson['note'],
        desc: parsedJson['desc'],
        dishType: parsedJson['dishType']);
  }

  MenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    menuName = documentSnapshot["menuName"] ?? "";
    kcal = documentSnapshot["kcal"] ?? 0.0;
    difficulty = documentSnapshot["difficulty"] ?? 0.0;

    preparationTime = documentSnapshot["preparationTime"] ?? 0.0;

    allergies = documentSnapshot["allergies"].cast<String>() ?? [];
    steps = documentSnapshot["steps"].cast<String>() ?? [];

    ingredients = List<MenuIngredientModel>.from(
        documentSnapshot["ingredients"].map((item) {
      return new MenuIngredientModel(
          id: item["id"], qty: item["qty"], unit: item["unit"]);
    }));

    note = documentSnapshot["note"] ?? "";

    desc = documentSnapshot["desc"] ?? "";
    dishType = documentSnapshot["dishType"] ?? 0;

    //ingredients =
    //  documentSnapshot["ingredients"].cast<MenuIngredientModel>() ?? [];
  }
}

extension MenuExtensions on QueryDocumentSnapshot {
  MenuModel get touser => MenuModel(
        id: this.id,
        menuName: this['menuName'],
        kcal: this['kcal'],
        difficulty: this['difficulty'],
        preparationTime: this['preparationTime'],
        allergies: this['allergies'],
        steps: this['steps'],
        ingredients: this['ingredients'],
        note: this['note'],
        desc: this['desc'],
        dishType: this['dishType'],
      );
}
