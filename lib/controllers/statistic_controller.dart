import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:morning_brief/models/cooked_menu_model.dart';
import 'package:morning_brief/services/cookedMenu_databse.dart';

class StatisticController extends GetxController {
  Rxn<CookedMenuModel> cookedMenu = Rxn<CookedMenuModel>();
  Rxn<List<CookedMenuModel>> cookedMenuList =
      Rxn<List<CookedMenuModel>>().obs();
  List<CookedMenuModel>? get cookedMenus => cookedMenuList.value.obs();

  RxList<FlSpot> points = RxList<FlSpot>().obs();
  @override
  void onInit() {
    super.onInit();

    cookedMenuList.bindStream(DatabaseCookedMenu().cookedMenuStream(false));
  }

  void getPoints() {
    points.clear();

    List<dynamic> list = [];
    for (double i = 1.0; i < 7; i++) {
      list.add({"x": i, "y": -1.0});
    }

    if (cookedMenuList.value != null)
      for (CookedMenuModel item in cookedMenuList.value ?? []) {
        list[item.cookedTime.toDate().weekday.toInt() - 1]['y'] +=
            item.kcal.toDouble();
      }
    list.forEach((el) {
      if (el['y'] != -1) points.add(FlSpot(el['x'], el['y'] + 1));
    });

    points.sort((a, b) => a.x.compareTo(b.x));
  }
}
