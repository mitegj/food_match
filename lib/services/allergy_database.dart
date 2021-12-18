import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/allergy_model.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseAllergy {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Stream<List<AllergyModel>> allergiesStream() {
    return _firestore
        .collection(conf
            .allergyCollection) // firebase non consente di usare le regex nei filtri quindi bisogna creare questo array denominato 'filters' con tutti i valori possibili per filtrarlo (alla creazione di una nuova location prendere nome e fare split)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AllergyModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(AllergyModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Stream<List<String>> userAllergiesStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    return _firestore
        .collection(conf.userCollection)
        .where('id', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(UserModel.fromDocumentSnapshot(element));
      }
      return retVal.length > 0 ? retVal[0].allergies : [];
    });
  }

  Future<RxList<String>> getUserAllergies() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    var result = await FirebaseFirestore.instance
        .collection(conf.userCollection)
        .where('id', isEqualTo: uid)
        .get();

    RxList<String> allergies = RxList();
    if (result.docs.isNotEmpty) {
      result.docs[0].data();
      for (final a in result.docs[0].data()["allergies"]) {
        allergies.add(a);
      }
    }
    return allergies;
  }

  Future<bool> updateAllergies(RxList isChecked) async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    try {
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .update({"allergies": getAllergiesId(isChecked)});
      return true;
    } catch (e) {
      print(e);
      return false;
      // popup errore
    }
  }

  List<String> getAllergiesId(RxList isChecked) {
    List<String> allergies = [];
    isChecked.forEach((el) {
      if (el.checked) allergies.add(el.id);
    });
    return allergies;
  }
}
