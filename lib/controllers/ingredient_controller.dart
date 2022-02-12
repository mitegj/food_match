import 'package:get/get.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/ingredientChecked_model.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/services/ingredient_databse.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';

class IngredientController extends GetxController {
  static IngredientController instance = Get.find();
  Rxn<IngredientModel> ingredient = Rxn<IngredientModel>();
  Rxn<List<IngredientModel>> ingredientList =
      Rxn<List<IngredientModel>>().obs();
  List<IngredientModel>? get ingredients => ingredientList.value.obs();

  RxList ingSearch = RxList().obs();

  Rxn<List<String>> userIngredientList = Rxn<List<String>>().obs();
  List<String>? get userIngredients => userIngredientList.value.obs();
/*
  Rxn<List<String>> userAllergyList = Rxn<List<String>>().obs();
  List<String>? get userAllergies => userAllergyList.value.obs();

*/
  bool isValueUpdated = false;

  RxList<IngredientChecked> _isChecked = RxList();

  @override
  void onInit() {
    super.onInit();

    Stream<List<IngredientModel>> ing = DatabaseIngredient().ingredientStream();
    ingredientList.bindStream(ing);

    userIngredientList.bindStream(DatabaseMenu().userInventoryStream());
    ingSearch.bindStream(ing);

    //  userAllergyList.bindStream(DatabaseAllergy().userAllergiesStream());
  }

  void filterIngredients(controller, String src) {
    ingSearch.clear();
    if (controller.ingredients != null)
      controller.ingredients!.forEach((el) => {
            if (el.name.toLowerCase().contains(src.toLowerCase()) ||
                src.trim() == "")
              {ingSearch.add(el)}
          });
  }

  getIngredientName(controller, index) {
    return controller.ingSearch![index].name.toString();
  }

  setIngredients(controller) {
    MenuController _menuController;
    try {
      _menuController = MenuController.instance;
    } catch (e) {
      _menuController = Get.put<MenuController>(MenuController());
    }

    controller
        .updateIngredients(_isChecked)
        .then((value) => {_menuController.getMenuList(FilterBody.listFilters)});
  }

  Future<bool> updateIngredients(RxList isChecked) async {
    return DatabaseIngredient().updateIngredients(isChecked);
  }

  getCheckValue(controller, index) {
    return _isChecked
        .where((el) => el.id == controller.ingSearch![index].id)
        .single
        .checked;
  }

  setCheckState(state, index, newValue) {
    _isChecked
        .where((el) => el.id == state.ingSearch[index].id)
        .single
        .checked = newValue!;

    _isChecked.refresh();

    if (!isValueUpdated) {
      isValueUpdated = true;
    }
  }

  setIngredientsCheck(state, index) {
    if (_isChecked.where((el) => el.id == state.ingSearch[index].id).isEmpty) {
      _isChecked.add(IngredientChecked(
          id: state.ingSearch[index].id,
          checked: state.userIngredients != null
              ? state.userIngredients.contains(state.ingSearch[index].id)
              : false));
    }
  }
}
