import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/widgets/settings/delete_account_bottomsheet.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
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
        HapticFeedback.lightImpact();
        Get.bottomSheet(DeleteAccountBottomSheet(
            authController: _authController, theme: theme));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'DELETEACCOUNT'.tr.toUpperCase(),
          style: GoogleFonts.poppins(
            color: theme.secondaryHeaderColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
