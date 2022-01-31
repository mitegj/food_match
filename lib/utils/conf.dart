import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Conf {
  String allergyCollection = "allergiesList";
  String userCollection = "users";
  String menuCollection = "menu";
  String inventoryCollection = "inventory";
  String inventoryListCollection = "ingredientsList";
  String cookedMenuCollection = "cookedMenu";
  String savedMenuCollection = "savedMenu";

  String appPlayStoreLink =
      "https://play.google.com/store/apps/details?id=appPackageName";
  String appAppStroreLink =
      "https://apps.apple.com/app/foodmatch-cook-have-fun/id1607696757";

  String lang = Get.deviceLocale.toString().split('_')[0].toUpperCase();
  String language = Get.deviceLocale.toString();
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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar("Opss", 'Could not launch $url');
    }
  }
}


//https://images.pexels.com/photos/349609/pexels-photo-349609.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260