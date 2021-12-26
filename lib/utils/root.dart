import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController.instance.checkUpdates();
    return LoadingWidget();
  }
}
