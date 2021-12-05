import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morning_brief/controllers/user_controller.dart';
import 'package:morning_brief/models/user_model.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/screens/onboarding.dart';
import 'package:morning_brief/services/user_database.dart';

class AuthController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
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

  void login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      assert(!user!.isAnonymous);
      final User? currentUser = _auth.currentUser;
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
                  {Get.off(() => AllergiesScreen())}
              });
        }
      }
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

  void logoutGoogle() async {
    try {
      await googleSignIn.signOut();

      await _auth.signOut().then((value) => Get.offAll(OnBoardingPage()));

      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
