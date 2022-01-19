import 'package:get/get.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/services/allergy_database.dart';
import 'package:morning_brief/services/ingredient_databse.dart';
import 'package:morning_brief/services/menu_database.dart';

class IngredientController extends GetxController {
  static IngredientController instance = Get.find();
  Rxn<IngredientModel> ingredient = Rxn<IngredientModel>();
  Rxn<List<IngredientModel>> ingredientList =
      Rxn<List<IngredientModel>>().obs();
  List<IngredientModel>? get ingredients => ingredientList.value.obs();

  RxList ingSearch = RxList().obs();

  Rxn<List<String>> userIngredientList = Rxn<List<String>>().obs();
  List<String>? get userIngredients => userIngredientList.value.obs();

  Rxn<List<String>> userAllergyList = Rxn<List<String>>().obs();
  List<String>? get userAllergies => userAllergyList.value.obs();

  @override
  void onInit() {
    super.onInit();
    ingredientList.bindStream(DatabaseIngredient().ingredientStream());

    userIngredientList.bindStream(DatabaseMenu().userInventoryStream());
    ingSearch.bindStream(DatabaseIngredient().ingredientStream());

    userAllergyList.bindStream(DatabaseAllergy().userAllergiesStream());
  }

  void filterIngredients(String src) {
    ingSearch.clear();
    if (ingredients != null)
      ingredients!.forEach((el) => {
            if (el.name.toLowerCase().contains(src.toLowerCase()) ||
                src.trim() == "")
              {ingSearch.add(el)}
          });
  }

/*
  updateStock(state, index, stocked, _userInventory) {
    UserInventory inv =
        _userInventory.where((el) => el.id == state.ingSearch[index].id).single;

    bool stock = stocked ? inv.stock = true : inv.stock = false;
    print(_userInventory);
    MenuController().updateStockCtrl(inv.id, stock);
    _userInventory.refresh();
  }
  */

  setUserInventoryCheck(state, index, _userInventory) {
    if (_userInventory
        .where((el) => el.id == state.ingSearch[index].id)
        .isEmpty) {
      _userInventory.add(UserInventory(
          id: state.ingSearch[index].id,
          stock:
              state.userIngredients != null ? getStock(state, index) : false));
    }
  }

  bool getStock(state, index) {
    bool stock = false;
    for (var element in state.userIngredients) {
      if (element.id == state.ingSearch[index].id) {
        stock = element.stock;
      }
    }

    return stock;
  }
}
