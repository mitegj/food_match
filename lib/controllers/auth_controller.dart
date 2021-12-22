import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/screens/contract.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/screens/onboarding.dart';
import 'package:morning_brief/services/user_database.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  final Conf conf = new Conf();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var googleSignInAccount = Rx<GoogleSignInAccount?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  static AuthController instance = Get.find();
  bool isNewUser = false;
  late UserCredential authResult;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => OnBoardingPage(),
          transition: Transition.leftToRight,
          duration: Duration(milliseconds: 250));
    } else {
      UserDatabase().saveUserLastLogin();
      Get.offAll(() => HomePage());
    }
  }

  void googleLogin() async {
    try {
      googleSignInAccount.value = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.value!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);

      if (authResult.additionalUserInfo!.isNewUser) {
        // se utente non esiste quando fa login lo creo con solo l'id
        if (user != null) {
          createUser(user.uid.toString()).then((value) => {
                Get.off(() => ContractScreen(),
                    transition: Transition.zoom,
                    duration: Duration(milliseconds: 300))
              });
        } else {
          print("errore");
        }
      }
      update();
      //Get.toNamed('/homeView'); // navigate to your wanted page
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
      UserModel _user = UserModel(
          id: uid,
          allergies: [],
          dinnerTime: 0,
          lastShop: DateTime.now(),
          name: '');

      await UserDatabase().createNewUser(_user);
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await googleSignIn.disconnect();

      await _auth.signOut();
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
          title: '',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("è presente una nuova versione, aggiorna l'app stronzo"),
              SizedBox(
                height: 30.0,
              ),
              TextButton(
                onPressed: () {
                  // TODO: verificare una volta in fase di test se funzionano

                  try {
                    if (Platform.isAndroid) {
                      launch(conf.appPlayStoreLink);
                    } else if (Platform.isIOS) {
                      launch(conf.appAppStroreLink);
                    }
                  } catch (e) {}
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          ),
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
}
