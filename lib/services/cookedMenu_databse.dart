import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/cooked_menu_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseCookedMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Stream<List<CookedMenuModel>> cookedMenuStream(bool monthly) {
    // monthly -> false per una visualizzazione settimanale

    final DateTime date = DateTime.now();
    final DateTime start = getDate(date
        .subtract(Duration(days: !monthly ? date.weekday - 1 : date.day - 1)));
    final DateTime end = getDate(date.add(Duration(
        days: !monthly
            ? (DateTime.daysPerWeek - date.weekday) + 1
            : DateTime.daysPerWeek + date.weekday)));

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      return _firestore
          .collection(conf.userCollection)
          .doc(uid)
          .collection(conf.cookedMenuCollection)
          .where("cookedTime",
              isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where("cookedTime", isLessThan: Timestamp.fromDate(end))
          .orderBy("cookedTime", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<CookedMenuModel> retVal = [];
        for (var element in query.docs) {
          retVal.add(CookedMenuModel.fromDocumentSnapshot(element));
        }
        return retVal;
      });
    } catch (e) {
      Get.snackbar(
        "Error getting cooked menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Stream.empty();
    }
  }
}
