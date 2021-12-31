import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/utils/UIColors.dart';

class ArrowHeader extends StatelessWidget {
  ArrowHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: UIColors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
