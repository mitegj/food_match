import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:get/get.dart';
import 'package:morning_brief/widgets/home/filters.dart';
import 'package:morning_brief/widgets/home/filters_body.dart';

class EmptySavedMenu extends StatelessWidget {
  EmptySavedMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: UIColors.particularBlack,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: UIColors.white,
                child: Icon(
                  Icons.bookmark,
                  size: 40,
                  color: UIColors.blue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("TRYADDSOMEBASICPRODUCT".tr,
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
                      child: Text("SAVEDMENULABEL".tr,
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
            ],
          ),
        ),
      ],
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
