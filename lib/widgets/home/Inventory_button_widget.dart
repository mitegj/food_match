import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/inventory/inventory_page.dart';

// ignore: camel_case_types
class Inventory_button_widget extends GetWidget<IngredientController> {
  const Inventory_button_widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        Get.to(() => InventoryScreen());
      },
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  UIColors.lightRed,
                  UIColors.blue,
                  UIColors.darkPurple,
                ],
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "VIEWINVENTARY".tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  CircleAvatar(
                    backgroundColor: UIColors.white.withOpacity(0.2),
                    child: Icon(Icons.arrow_forward, color: UIColors.blue),
                  ),
                ],
              ),
              Text(
                "LASTUPDATE".tr.toLowerCase() +
                    ", " +
                    controller.lastInventoryUpd.toLowerCase(),
                style: GoogleFonts.poppins(
                    color: UIColors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )),
    );
  }
}
