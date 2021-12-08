import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  RxString appCurrentVersion = "".obs;
  @override
  void onInit() {
    super.onInit();
    getFutureAppCurrentVersion();
  }

  void openEmailFeedback() async {
    final url =
        Uri.encodeFull('mailto:beyondx.team@gmail.com?subject=Feedback&body=');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        "Errore durante l'apertura dell'app Mail",
        'Impossibile eseguire $url',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() {
    // controllo se ios o android
    AuthController().logoutGoogle();
  }

  Future<void> getFutureAppCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appCurrentVersion.value = packageInfo.version;
  }
}
