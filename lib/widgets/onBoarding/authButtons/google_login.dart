import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';

class GoogleLogin extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 0.0),
      child: GestureDetector(
        onTap: () => AuthController.instance.googleLogin(),
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
                child: Image.asset("assets/icons/googleLogo.png"),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Login with Google',
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
