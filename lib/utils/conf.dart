import 'package:get/get.dart';

class Conf {
  String allergyCollection = "allergies";
  String userCollection = "users";
  String menuCollection = "menu";
  String inventoryCollection = "inventory";
  String inventoryListCollection = "ingredients";
  String cookedMenuCollection = "cookedMenu";

  String appPlayStoreLink =
      "https://play.google.com/store/apps/details?id=appPackageName";
  String appAppStroreLink =
      "https://apps.apple.com/it/app/tiktok-video-live-e-musica/id835599320";

  String lang = Get.deviceLocale.toString().split('_')[0].toUpperCase();
}
