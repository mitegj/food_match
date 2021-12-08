import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/utils/conf.dart';

class UserDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection(conf.userCollection).doc(user.id).set({
        "id": user.id,
        "allergies": user.allergies,
        "dinnerTime": user.dinnerTime,
        "lastShop": user.lastShop,
        "name": user.name
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection(conf.userCollection).doc(uid).get();

      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection("todos")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<String>> userIngrediensStream() {
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
      return retVal[0].allergies;
    });
  }
}
