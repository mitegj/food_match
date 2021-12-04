import 'package:cloud_firestore/cloud_firestore.dart';

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
    id = documentSnapshot["id"] ?? "";
    stock = documentSnapshot["stock"] ?? 0;
  }
}

extension UserInventoryExtensions on QueryDocumentSnapshot {
  UserInventory get toInventory =>
      UserInventory(id: this.id, stock: this['stock']);
}
