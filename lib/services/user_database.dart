import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/models/user_model.dart';
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
        "ingredients": [],
        "lastLogin": DateTime.now()
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

  Future<void> deleteUser() async {
    try {
      AuthController authController;
      try {
        authController = AuthController.instance;
      } catch (e) {
        authController = Get.put<AuthController>(AuthController());
      }
      bool logged = false;
      if (await authController.whichLoginType() == "google")
        logged = await authController.googleLogin(true);
      else if (await authController.whichLoginType() == "apple")
        logged = await authController.signInWithApple(true);
      else
        authController.logout();

      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      if (logged) {
        await _firestore.collection(conf.userCollection).doc(uid).delete();
        await FirebaseAuth.instance.currentUser?.delete();

        await FirebaseAuth.instance.signOut();
      }
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

  Future<void> saveUserLastInventoryUpdate() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await FirebaseFirestore.instance
          .collection(conf.userCollection)
          .doc(uid)
          .update({"lastInventoryUpd": new DateTime.now()});
    } catch (e) {}
  }
}
