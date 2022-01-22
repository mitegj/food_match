import 'package:get/get.dart';
import 'package:morning_brief/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel(
    id: '',
    allergies: [],
    ingredients: [],
    lastLogin: DateTime.now(),
  ).obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;
}
