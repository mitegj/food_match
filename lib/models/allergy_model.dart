import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morning_brief/utils/conf.dart';

final Conf conf = new Conf();

class AllergyModel {
  late String id;
  late String name;
  AllergyModel({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {"id": id, "name" + conf.lang: name};
  }

  AllergyModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    name = conf.docContains("name" + conf.lang, documentSnapshot)
        ? documentSnapshot["name" + conf.lang]
        : '';
  }

  AllergyModel.fromListDocumentSnapshot(var obj) {
    id = obj['id'];
    name = obj["name" + conf.lang];
  }
}

extension AllergyExtensions on QueryDocumentSnapshot {
  AllergyModel get toAllergy => AllergyModel(
        id: this.id,
        name: this['name' + conf.lang],
      );
}
