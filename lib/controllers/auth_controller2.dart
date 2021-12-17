import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morning_brief/controllers/user_controller.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/screens/contract.dart';
import 'package:morning_brief/services/user_database.dart';
import 'package:morning_brief/utils/conf.dart';
import 'package:morning_brief/utils/root.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthControllerDue extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  final Conf conf = new Conf();
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(auth.authStateChanges());
  }

  Future<bool> createUser(String uid) async {
    try {
      UserModel _user = UserModel(
          id: uid,
          allergies: [],
          dinnerTime: 0,
          lastShop: DateTime.now(),
          name: '');

      if (await UserDatabase().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return false;
  }

  void signInWithGoogle() async {
    try {
      googleAcc.value = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleAcc.value!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      final User? currentUser = auth.currentUser;
      assert(user!.uid == currentUser!.uid);

      if (authResult.additionalUserInfo!.isNewUser) {
        // se utente non esiste quando fa login lo creo con solo l'id
        if (user != null) {
          Future<bool> done = createUser(user.uid.toString());
          done.then((value) => {
                if (!value)
                  {
                    print("something went wrong, user not created")
                  } // TODO: popup che segnali che non è andato
                else
                  {Get.off(() => ContractScreen())}
              });
        }
      }

      isSignedIn.value = true;
      update(); // <-- without this the isSignedin value is not updated.
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.black);
    }
  }

  void signout() async {
    try {
      await auth.signOut();
      await _googleSignIn.signOut();
      isSignedIn.value = false;
      update();
      Get.offAll(() => Root());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.black);
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
