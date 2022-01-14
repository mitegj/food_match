import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class UserModel {
  late String id;
  late String name;
  late List<String> allergies;

  late DateTime lastLogin;
  UserModel(
      {required this.id,
      required this.name,
      required this.allergies,
      required this.lastLogin});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "allergies,": allergies,

      "lastLogin": lastLogin,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      id: parsedJson['id'],
      name: parsedJson['name'],
      allergies: parsedJson['allergies'],

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
        lastLogin: this['lastLogin'],
      );
}
