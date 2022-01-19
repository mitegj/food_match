import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class UserInventory {
  late String id;
  late bool stock;
  UserInventory({
    required this.id,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "stock": stock,
    };
  }

  factory UserInventory.fromJson(Map<String, dynamic> parsedJson) {
    return UserInventory(
      id: parsedJson['id'],
      stock: parsedJson['stock'],
    );
  }

  UserInventory.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = conf.docContains("id", documentSnapshot) ? documentSnapshot["id"] : "";
    stock = conf.docContains("stock", documentSnapshot)
        ? documentSnapshot["stock"]
        : false;
  }

  UserInventory.fromListDocumentSnapshot(
    var obj,
  ) {
    id = obj['id'];
  }
}

extension UserInventoryExtensions on QueryDocumentSnapshot {
  UserInventory get toInventory =>
      UserInventory(id: this.id, stock: this['stock']);
}
