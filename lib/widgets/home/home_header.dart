import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:morning_brief/screens/statistics.dart';

import 'package:morning_brief/utils/UIColors.dart';

import 'package:morning_brief/widgets/inventory/inventory_page.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      color: theme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'foodmatch.',
                style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      Get.to(() => StatisticsScreen());
                      //Get.to(() => StatsPage());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      /*Get.bottomSheet(InventoryBottomSheet(),
                      isScrollControlled: true);*/
                      Get.offAll(() => InventoryScreen());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_bag,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      /*Get.bottomSheet(InventoryBottomSheet(),
                      isScrollControlled: true);*/
                      Get.offAll(() => InventoryScreen());
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
