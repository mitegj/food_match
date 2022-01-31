import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/utils/UIColors.dart';

class ArrowHeader extends StatelessWidget {
  ArrowHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.arrow_back,
          color: UIColors.white,
        ),
      ),
    );
  }
}
