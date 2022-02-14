import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/services/allergy_database.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class UserModel {
  late String id;
  late String name;
  late List<String> allergies;
  late List<String> ingredients;
  late DateTime lastLogin;
  late DateTime lastInventoryUpd;
  UserModel(
      {required this.id,
      required this.allergies,
      required this.ingredients,
      required this.lastLogin,
      required this.lastInventoryUpd});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "allergies,": allergies,
      "ingredients,": ingredients,
      "lastLogin": lastLogin,
      "lastInventoryUpd":lastInventoryUpd
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      id: parsedJson['id'],
      allergies: parsedJson['allergies'],
      ingredients: parsedJson['ingredients'],
      lastLogin: parsedJson['lastLogin'],
      lastInventoryUpd: parsedJson['lastInventoryUpd']
    );
  }

  UserModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = conf.docContains("name", documentSnapshot)
        ? documentSnapshot["name"]
        : "";
    allergies = conf.docContains("allergies", documentSnapshot)
        ? documentSnapshot["allergies"].cast<String>()
        : [];
    ingredients = conf.docContains("ingredients", documentSnapshot)
        ? documentSnapshot["ingredients"].cast<String>()
        : [];
    lastLogin = conf.docContains("lastLogin", documentSnapshot)
        ? documentSnapshot["lastLogin"].toDate()
        : DateTime.now();

    lastInventoryUpd= conf.docContains("lastInventoryUpd", documentSnapshot)
        ? documentSnapshot["lastInventoryUpd"].toDate()
        : DateTime.now();
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  UserModel get touser => UserModel(
        id: this.id,
        allergies: this['allergies'],
        ingredients: this['ingredients'],
        lastLogin: this['lastLogin'],
        lastInventoryUpd: this['lastInventoryUpd']
      );
}
