import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class CookedMenuModel {
  late String id;
  late String name;
  late Timestamp cookedTime;
  late int dishType;
  late int kcal;
  late int preparationTime;
  CookedMenuModel(
      {required this.id,
      required this.name,
      required this.cookedTime,
      required this.dishType,
      required this.kcal,
      required this.preparationTime});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "cookedTime": cookedTime,
      "dishType": dishType,
      "kcal": kcal,
      "preparationTime": preparationTime
    };
  }

  CookedMenuModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = conf.docContains("name", documentSnapshot)
        ? documentSnapshot["name"]
        : '';
    cookedTime = conf.docContains("cookedTime", documentSnapshot)
        ? documentSnapshot["cookedTime"]
        : new Timestamp.now();
    dishType = conf.docContains("dishType", documentSnapshot)
        ? documentSnapshot["dishType"]
        : 0;
    kcal = conf.docContains("kcal", documentSnapshot)
        ? documentSnapshot["kcal"]
        : 0;
    preparationTime = conf.docContains("preparationTime", documentSnapshot)
        ? documentSnapshot["preparationTime"]
        : 0;
  }
}

extension CookedMenuExtensions on QueryDocumentSnapshot {
  CookedMenuModel get toCookedMenu => CookedMenuModel(
        id: this.id,
        name: this['name'],
        cookedTime: this['cookedTime'],
        dishType: this['dishType'],
        kcal: this['kcal'],
        preparationTime: this['preparationTime'],
      );
}
