import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';

class DisconnectAccountButton extends StatelessWidget {
  const DisconnectAccountButton({
    Key? key,
    required AuthController authController,
  })  : _authController = authController,
        super(key: key);

  final AuthController _authController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        _authController.logout();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: UIColors.detailBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("DISCONNECTACCOUNT".tr,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
            CircleAvatar(
              backgroundColor: UIColors.black.withOpacity(0.6),
              child: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.red[500],
              ),
            )
          ],
        ),
      ),
    );
  }
}
