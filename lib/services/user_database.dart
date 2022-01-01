import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/screens/onboarding.dart';
import 'package:morning_brief/utils/conf.dart';

class UserDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  Future<void> saveUserLastLogin() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .update({"lastLogin": new DateTime.now()});
    } catch (e) {}
  }

  Future<void> createNewUser(UserModel user) async {
    try {
      await _firestore.collection(conf.userCollection).doc(user.id).set({
        "id": user.id,
        "allergies": user.allergies,
        "lastShop": user.lastShop,
        "name": user.name
      });
    } catch (e) {
      Get.snackbar(
        "Error creating user",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var googleSignInAccount = Rx<GoogleSignInAccount?>(null);
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignInAccount.value = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.value!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      _auth.signInWithCredential(credential);

      User? user = _auth.currentUser;
      user?.delete();
      await _firestore.collection(conf.userCollection).doc(uid).delete();
      // Get.offAll(() => OnBoardingPage());
    } catch (e) {
      Get.snackbar(
        "Error creating user",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Stream<List<String>> userIngrediensStream() {
    try {
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
    } catch (e) {
      Get.snackbar(
        "Error user ingredient",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }
}
