import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morning_brief/models/cooked_menu_model.dart';
import 'package:morning_brief/utils/conf.dart';

class DatabaseCookedMenu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Conf conf = new Conf();

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Stream<List<CookedMenuModel>> cookedMenuStream(bool monthly) {
    // monthly -> false per una visualizzazione settimanale
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    final DateTime date = DateTime.now();
    final DateTime start = getDate(date
        .subtract(Duration(days: monthly ? date.weekday - 1 : date.day - 1)));
    final DateTime end = getDate(date.add(Duration(
        days: monthly
            ? DateTime.daysPerWeek - date.weekday
            : DateTime.daysPerWeek + date.weekday)));
    return _firestore
        .collection(conf.userCollection)
        .doc(uid)
        .collection(conf.cookedMenuCollection)
        .where("cookedTime", isGreaterThanOrEqualTo: start)
        .where("cookedTime", isLessThanOrEqualTo: end)
        .orderBy("cookedTime")
        .snapshots()
        .map((QuerySnapshot query) {
      List<CookedMenuModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(CookedMenuModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }
}
