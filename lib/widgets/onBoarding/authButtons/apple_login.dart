import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller2.dart';
import 'package:morning_brief/utils/UIColors.dart';

class AppleLogin extends StatelessWidget {
  AppleLogin({required this.onPressed});
  final VoidCallback onPressed;
  /*Future<void> signInWithApple(BuildContext context) async {
    await Authentification().signInWithApple(context);
  }*/

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthControllerDue>();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        //onTap: () => signInWithGoogle(context),
        onTap: () => _authController.signInWithGoogle(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: Image.asset("assets/icons/appleLogo.png"),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Login with Apple',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
