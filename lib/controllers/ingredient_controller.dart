import 'package:get/get.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/services/ingredient_databse.dart';
import 'package:morning_brief/services/menu_database.dart';

class IngredientController extends GetxController {
  Rxn<IngredientModel> ingredient = Rxn<IngredientModel>();
  Rxn<List<IngredientModel>> ingredientList =
      Rxn<List<IngredientModel>>().obs();
  List<IngredientModel>? get ingredients => ingredientList.value.obs();

  RxList ingSearch = RxList().obs();

  Rxn<List<UserInventory>> userIngredientList =
      Rxn<List<UserInventory>>().obs();
  List<UserInventory>? get userIngredients => userIngredientList.value.obs();

  void filterIngredients(String src) {
    ingSearch.clear();
    if (ingredients != null)
      ingredients!.forEach((el) => {
            if (el.listName.contains(src) || src.trim() == "")
              {ingSearch.add(el)}
          });
  }

  @override
  void onInit() {
    super.onInit();
    ingredientList.bindStream(DatabaseIngredient().ingredientStream());

    userIngredientList.bindStream(DatabaseMenu().userInventoryStream());
    ingSearch.bindStream(DatabaseIngredient().ingredientStream());
  }
}
