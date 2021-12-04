import 'package:cloud_firestore/cloud_firestore.dart';

class AllergyModel {
  late String id;
  late String name;
  AllergyModel({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  AllergyModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"] ?? 0;
  }
}

extension AllergyExtensions on QueryDocumentSnapshot {
  AllergyModel get tomenu => AllergyModel(
        id: this.id,
        name: this['name'],
      );
}
