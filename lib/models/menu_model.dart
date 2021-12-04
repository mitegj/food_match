import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  late String menuName;
  late double kcal;
  late double difficulty;
  late DateTime lastTimeEaten;
  late double preparationTime;
  late List<String> allergies;

  MenuModel(
      {required this.menuName,
      required this.kcal,
      required this.difficulty,
      required this.lastTimeEaten,
      required this.preparationTime,
      required this.allergies});

  Map<String, dynamic> toMap() {
    return {
      "menuName": menuName,
      "kcal": kcal,
      "difficulty,": difficulty,
      "lastTimeEaten": lastTimeEaten,
      "preparationTime": preparationTime,
      "allergies": allergies,
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> parsedJson) {
    return MenuModel(
      menuName: parsedJson['menuName'],
      kcal: parsedJson['kcal'],
      difficulty: parsedJson['difficulty'],
      lastTimeEaten: parsedJson['lastTimeEaten'],
      preparationTime: parsedJson['preparationTime'],
      allergies: parsedJson['allergies'],
    );
  }

  MenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    menuName = documentSnapshot["menuName"] ?? "";
    kcal = documentSnapshot["kcal"] ?? 0.0;
    difficulty = documentSnapshot["difficulty"] ?? 0.0;
    lastTimeEaten =
        documentSnapshot["lastTimeEaten"].toDate() ?? DateTime.now();
    preparationTime = documentSnapshot["preparationTime"] ?? 0.0;

    allergies = documentSnapshot["allergies"].cast<String>() ?? [];
  }
}

extension MenuExtensions on QueryDocumentSnapshot {
  MenuModel get touser => MenuModel(
        menuName: this['menuName'],
        kcal: this['kcal'],
        difficulty: this['difficulty'],
        lastTimeEaten: this['lastTimeEaten'],
        preparationTime: this['preparationTime'],
        allergies: this['allergies'],
      );
}
