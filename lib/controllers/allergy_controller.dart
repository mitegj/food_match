import 'package:get/get.dart';
import 'package:morning_brief/models/allergy_model.dart';
import 'package:morning_brief/services/allergy_database.dart';

class AllergyController extends GetxController {
  Rxn<AllergyModel> allergy = Rxn<AllergyModel>();
  Rxn<List<AllergyModel>> allergyList = Rxn<List<AllergyModel>>().obs();
  List<AllergyModel>? get allergies => allergyList.value.obs();

  Rxn<List<String>> userAllergyList = Rxn<List<String>>().obs();
  List<String>? get userAllergies => userAllergyList.value.obs();

  @override
  void onInit() {
    super.onInit();
    allergyList.bindStream(DatabaseAllergy().allergiesStream());
    userAllergyList.bindStream(DatabaseAllergy().userAllergiesStream());
  }

  Future<bool> updateAllergies(RxList isChecked) async {
    return DatabaseAllergy().updateAllergies(isChecked);
  }
}
