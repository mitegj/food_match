import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';

class GoogleLogin extends GetWidget<AuthController> {
  GoogleLogin({Key? key, required this.checked}) : super(key: key);
  final RxBool checked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      child: GestureDetector(
        onTap: () => {
          if (checked.value)
            {AuthController.instance.googleLogin()}
          else
            {
              Get.snackbar("ACCEPTTHETERMS".tr + ".", "MUSTACCEPT".tr,
                  colorText: UIColors.white)
            }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'CONTINUEWITH'.tr + ' Google',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
