import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/filters_header.dart';
import 'package:morning_brief/widgets/home/home_body.dart';
import 'package:morning_brief/widgets/home/home_header.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class HomePage extends GetWidget<IngredientController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(children: [
        HomeHeader(),
        SizedBox(height: 10),
        HomeBody(),
      ])),
    );
  }
}
