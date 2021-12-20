import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/screens/homepage.dart';

import 'package:morning_brief/utils/UIColors.dart';

class ArrowHeader extends StatelessWidget {
  ArrowHeader({Key? key, required this.home}) : super(key: key);
  final bool home;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      padding: const EdgeInsets.all(0),
      color: theme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: UIColors.black,
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: UIColors.white,
                ),
                onPressed: () {
                  home
                      ? Get.offAll(() => HomePage(),
                          transition: Transition.leftToRight,
                          duration: Duration(milliseconds: 250))
                      : Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
