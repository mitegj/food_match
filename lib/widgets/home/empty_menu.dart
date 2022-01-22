import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:get/get.dart';
import 'package:morning_brief/widgets/filter/filters.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/inventory/inventory_page.dart';

class EmptyMenu extends StatelessWidget {
  EmptyMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: headerBeforeCard(),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: UIColors.particularBlack,
            ),
            child: Column(
              children: [
                Text(
                  "✌️",
                  style: TextStyle(fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("EMPTYSCREENMESSAGE".tr,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("EMPTYSCREENMESSAGE1".tr,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("EMPTYSCREENMESSAGE2".tr,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Get.to(() => InventoryScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'VIEWINVENTORY'.tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.detailBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerBeforeCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SCROLLFORMORE'.tr,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.6)),
          ),
          filtersIcon(),
        ],
      ),
    );
  }

  Widget filtersIcon() {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        Get.to(() => FiltersPage());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.filter_alt_outlined,
            color: UIColors.white,
          ),
          FilterBody.listFilters.length > 0
              ? Positioned(
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: UIColors.violetMain,
                  ),
                  top: -5,
                  right: -10,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
