import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class MenuModel {
  late String id;
  late String menuName;
  late int kcal;
  late int difficulty;
  late int preparationTime;
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
      "name" + conf.lang: menuName,
      "kcal": kcal,
      "difficulty,": difficulty,
      "preparationTime": preparationTime,
      "allergies": allergies,
      "steps" + conf.lang: steps,
      "ingredients": ingredients,
      "note" + conf.lang: note,
      "desc" + conf.lang: desc,
      "dishType": dishType
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuModel(
        id: parsedJson["id"],
        menuName: parsedJson['name' + conf.lang],
        kcal: parsedJson['kcal'],
        difficulty: parsedJson['difficulty'],
        preparationTime: parsedJson['preparationTime'],
        allergies: parsedJson['allergies'],
        steps: parsedJson['steps' + conf.lang],
        ingredients: parsedJson['ingredients'],
        note: parsedJson['note' + conf.lang],
        desc: parsedJson['desc' + conf.lang],
        dishType: parsedJson['dishType']);
  }

  MenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    menuName = documentSnapshot["name" + conf.lang] ?? "";
    kcal = documentSnapshot["kcal"] ?? 0.0;
    difficulty = documentSnapshot["difficulty"] ?? 0.0;

    preparationTime = documentSnapshot["preparationTime"] ?? 0.0;

    allergies = documentSnapshot["allergies"].cast<String>() ?? [];
    steps = documentSnapshot["steps" + conf.lang].cast<String>() ?? [];

    ingredients = List<MenuIngredientModel>.from(
        documentSnapshot["ingredients"].map((item) {
      return new MenuIngredientModel(
          id: item["id"], qty: item["qty"], unit: item["unit"]);
    }));

    note = documentSnapshot["note" + conf.lang] ?? "";

    desc = documentSnapshot["desc" + conf.lang] ?? "";
    dishType = documentSnapshot["dishType"] ?? 0;

    //ingredients =
    //  documentSnapshot["ingredients"].cast<MenuIngredientModel>() ?? [];
  }
}

extension MenuExtensions on QueryDocumentSnapshot {
  MenuModel get touser => MenuModel(
        id: this.id,
        menuName: this['menu' + conf.lang],
        kcal: this['kcal'],
        difficulty: this['difficulty'],
        preparationTime: this['preparationTime'],
        allergies: this['allergies'],
        steps: this['steps' + conf.lang],
        ingredients: this['ingredients'],
        note: this['note' + conf.lang],
        desc: this['desc' + conf.lang],
        dishType: this['dishType'],
      );
}
