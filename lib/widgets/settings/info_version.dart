import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/setting_controller.dart';

class InfoVersion extends StatelessWidget {
  const InfoVersion({
    Key? key,
    required SettingController settingController,
    required this.theme,
  })  : _settingController = settingController,
        super(key: key);

  final SettingController _settingController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Obx(() => Text(
              _settingController.appCurrentVersion.value,
              style: GoogleFonts.poppins(
                color: theme.secondaryHeaderColor,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            )));
  }
}
