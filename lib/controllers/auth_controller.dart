import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/screens/onboarding.dart';
import 'package:morning_brief/services/user_database.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:morning_brief/widgets/global_input/first_step.dart';
import 'package:package_info/package_info.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  final Conf conf = new Conf();
  GoogleSignIn googleSignIn = GoogleSignIn();
  var googleSignInAccount = Rx<GoogleSignInAccount?>(null);
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> user;
  static AuthController instance = Get.find();
  late UserCredential authResult;

  @override
  void onReady() {
    super.onReady();

    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? usr) async {
    await Future.delayed(const Duration(microseconds: 50), () {
      if (user.value == null) {
        Get.offAll(() => OnBoardingPage(), transition: Transition.leftToRight);
      } else {
        UserDatabase().saveUserLastLogin();
        Get.offAll(() => HomePage(isFirstLogin: false));
      }
    });
  }

  void googleLogin() async {
    try {
      googleSignIn = GoogleSignIn();
      googleSignInAccount.value = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.value!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      afterLoginControl(credential);
      return;
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> createUser(String uid) async {
    try {
      UserModel user = UserModel(
          id: uid, allergies: [], ingredients: [], lastLogin: DateTime.now());

      await UserDatabase().createNewUser(user);
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteUser() async {
    try {
      UserDatabase().deleteUser();
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    // funziona sia con google che con apple
    try {
      await googleSignIn.disconnect();

      await auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> checkUpdates() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();

    final String latestBuildNumber =
        removeLastDigit(remoteConfig.getString("version"));

    final String currentBuildNumber = removeLastDigit(packageInfo.version);

    int latestVersion = getExtendedVersionNumber(latestBuildNumber);
    int currentVersion = getExtendedVersionNumber(currentBuildNumber);

    if (currentVersion < latestVersion) {
      Get.defaultDialog(
          backgroundColor: UIColors.black,
          title: '\n' + 'UPDATETHEAPP'.tr,
          titleStyle: TextStyle(color: UIColors.white),
          middleText: 'NEWVERSIONAVAIABLE'.tr + '\n',
          middleTextStyle: TextStyle(color: UIColors.white),
          textConfirm: "OK",
          confirmTextColor: UIColors.white,
          buttonColor: UIColors.darkPurple,
          onConfirm: () {
            try {
              if (Platform.isAndroid) {
                launch(conf.appPlayStoreLink);
              } else if (Platform.isIOS) {
                launch(conf.appAppStroreLink);
              }
            } catch (e) {}
          },
          radius: 10.0);
    }
  }

  String removeLastDigit(String version) {
    List<String> l = version.split('.');
    l.removeLast();

    return l.join('.');
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 10000 + versionCells[1] * 100; // versionCells[2]
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void afterLoginControl(AuthCredential credential) async {
    authResult = await auth.signInWithCredential(credential);

    final User? user = authResult.user;
    assert(!user!.isAnonymous);
    final User? currentUser = auth.currentUser;
    assert(user!.uid == currentUser!.uid);

    if (authResult.additionalUserInfo!.isNewUser) {
      // se utente non esiste quando fa login lo creo con solo l'id

      Get.to(() => FirsStep());
      if (user != null) {
        createUser(user.uid.toString()).then((value) => {});
      } else {
        Get.snackbar(
          "Error signing in",
          "",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    update();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    afterLoginControl(oauthCredential);

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
