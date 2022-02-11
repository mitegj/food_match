import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/saved_menu.dart';
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
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'foodmatch.',
                  style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(() => StatisticsScreen());
                },
                child: CircleAvatar(
                  backgroundColor: UIColors.violetMain.withOpacity(0.2),
                  child: Icon(
                    Icons.account_circle,
                    color: UIColors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(
                    () => Scaffold(
                      backgroundColor: theme.backgroundColor,
                      body: SafeArea(
                        child: SavedMenuPage(),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.violetMain.withOpacity(0.2),
                    child: Icon(Icons.bookmark, color: UIColors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(() => InventoryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.violetMain.withOpacity(0.2),
                    child: Icon(Icons.view_headline, color: UIColors.white),
                  ),
                ),
              )
              /*Align(
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
                      HapticFeedback.mediumImpact();
                      Get.to(() => StatisticsScreen());
                      //Get.to(() => StatsPage());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
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
                      HapticFeedback.mediumImpact();
                      Get.to(
                        () => Scaffold(
                          backgroundColor: theme.backgroundColor,
                          body: SafeArea(
                            child: SavedMenuPage(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: UIColors.detailBlack,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(
                      Icons.receipt_long,
                      color: UIColors.white,
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Get.to(() => InventoryScreen());
                    },
                  ),
                ),
              ),*/
            ],
          )
        ],
      ),
    );
  }
}
