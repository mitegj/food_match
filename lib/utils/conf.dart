import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Conf {
  String allergyCollection = "allergies";
  String userCollection = "users";
  String menuCollection = "menu";
  String inventoryCollection = "inventory";
  String inventoryListCollection = "ingredients";
  String cookedMenuCollection = "cookedMenu";
  String savedMenuCollection = "savedMenu";

  String appPlayStoreLink =
      "https://play.google.com/store/apps/details?id=appPackageName";
  String appAppStroreLink =
      "https://apps.apple.com/it/app/tiktok-video-live-e-musica/id835599320";

  String lang = Get.deviceLocale.toString().split('_')[0].toUpperCase();

  var iubendaLink = {
    "IT": {
      "privacy": "https://www.iubenda.com/privacy-policy/40397842",
      "terms": "https://www.iubenda.com/termini-e-condizioni/40397842"
    },
    "EN": {
      "privacy": "https://www.iubenda.com/privacy-policy/16023868",
      "terms": "https://www.iubenda.com/terms-and-conditions/16023868"
    }
  };

  bool docContains(String key, DocumentSnapshot doc) {
    String s = doc.data().toString();
    return s.contains(key.trim() + ':');
  }
}


//https://images.pexels.com/photos/349609/pexels-photo-349609.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260