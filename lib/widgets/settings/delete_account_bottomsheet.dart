import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/auth_controller.dart';

import 'package:morning_brief/utils/UIColors.dart';

// ignore: must_be_immutable
class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({
    Key? key,
    required AuthController authController,
    required this.theme,
  })  : _authController = authController,
        super(key: key);
  final AuthController _authController;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.50,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
          ),
          color: UIColors.detailBlack),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("DELETEACCOUNTLABEL".tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
              InkWell(
                onTap: () {
                  _authController.deleteUser();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'DELETEACCOUNT'.tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: Text(
                    'DONTCANCELACCOUNT'.tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
