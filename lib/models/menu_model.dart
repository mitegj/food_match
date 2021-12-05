import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';

class MenuModel {
  late String menuName;
  late int kcal;
  late double difficulty;
  late double preparationTime;
  late List<String> allergies;
  late List<String> steps;
  late List<MenuIngredientModel?> ingredients;

  MenuModel(
      {required this.menuName,
      required this.kcal,
      required this.difficulty,
      required this.preparationTime,
      required this.allergies,
      required this.steps,
      required this.ingredients});

  Map<String, dynamic> toMap() {
    return {
      "menuName": menuName,
      "kcal": kcal,
      "difficulty,": difficulty,
      "preparationTime": preparationTime,
      "allergies": allergies,
      "steps": steps,
      "ingredients": ingredients,
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuModel(
      menuName: parsedJson['menuName'],
      kcal: parsedJson['kcal'],
      difficulty: parsedJson['difficulty'],
      preparationTime: parsedJson['preparationTime'],
      allergies: parsedJson['allergies'],
      steps: parsedJson['steps'],
      ingredients: parsedJson['ingredients'],
    );
  }

  MenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
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

    //ingredients =
    //  documentSnapshot["ingredients"].cast<MenuIngredientModel>() ?? [];
  }
}

extension MenuExtensions on QueryDocumentSnapshot {
  MenuModel get touser => MenuModel(
        menuName: this['menuName'],
        kcal: this['kcal'],
        difficulty: this['difficulty'],
        preparationTime: this['preparationTime'],
        allergies: this['allergies'],
        steps: this['steps'],
        ingredients: this['ingredients'],
      );
}
