import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';

class deleteAccount extends StatelessWidget {
  const deleteAccount({
    Key? key,
    required AuthController authController,
    required this.theme,
  })  : _authController = authController,
        super(key: key);

  final AuthController _authController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _authController.deleteUser();
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'DELETEACCOUNT'.tr,
          style: GoogleFonts.poppins(
            color: theme.secondaryHeaderColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
