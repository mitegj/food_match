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
    if (cookedMenuList.value != null)
      for (CookedMenuModel item in cookedMenuList.value ?? []) {
        points.add(FlSpot(
            item.cookedTime.toDate().weekday.toDouble(), item.kcal.toDouble()));
      }

    points.sort((a, b) => a.x.compareTo(b.x));
  }
}
