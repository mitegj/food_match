import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class UserModel {
  late String id;
  late String name;
  late List<String> allergies;
  late DateTime lastShop;
  late DateTime lastLogin;
  UserModel(
      {required this.id,
      required this.name,
      required this.allergies,
      required this.lastShop,
      required this.lastLogin});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "allergies,": allergies,
      "lastShop": lastShop,
      "lastLogin": lastLogin,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      id: parsedJson['id'],
      name: parsedJson['name'],
      allergies: parsedJson['allergies'],
      lastShop: parsedJson['lastShop'],
      lastLogin: parsedJson['lastLogin'],
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
    lastShop = conf.docContains("lastShop", documentSnapshot)
        ? documentSnapshot["lastShop"].toDate()
        : DateTime.now();
    lastLogin = conf.docContains("lastLogin", documentSnapshot)
        ? documentSnapshot["lastLogin"].toDate()
        : DateTime.now();
  }
}

extension UserExtensions on QueryDocumentSnapshot {
  UserModel get touser => UserModel(
        id: this.id,
        name: this['name'],
        allergies: this['allergies'],
        lastShop: this['lastShop'],
        lastLogin: this['lastLogin'],
      );
}
