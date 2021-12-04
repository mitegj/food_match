import 'package:get/get.dart';
import 'package:morning_brief/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel(
          id: '',
          allergies: [],
          dinnerTime: 0,
          lastShop: DateTime.now(),
          name: '')
      .obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel(
        id: '',
        allergies: [],
        dinnerTime: 0,
        lastShop: DateTime.now(),
        name: '');
  }
}
