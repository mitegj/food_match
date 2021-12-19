import 'package:cloud_firestore/cloud_firestore.dart';

class CookedMenuModel {
  late String id;
  late String name;
  late Timestamp cookedTime;
  late int dishType;
  late int kcal;
  late double preparationTime;
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
    name = documentSnapshot["name"];
    cookedTime = documentSnapshot["cookedTime"];
    dishType = documentSnapshot["dishType"];
    kcal = documentSnapshot["kcal"];
    preparationTime = documentSnapshot["preparationTime"];
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
