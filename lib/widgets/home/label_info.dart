import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/inventory/inventory_page.dart';

// ignore: camel_case_types
class labelInfoInventory extends StatelessWidget {
  const labelInfoInventory({Key? key, required this.visibilityInventary})
      : super(key: key);

  final RxBool visibilityInventary;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: visibilityInventary.value,
          child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.detailBlack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                          text: "DAILYUPDATEINVENTORY".tr,
                          style: GoogleFonts.poppins(
                              color: UIColors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                          children: <TextSpan>[
                            TextSpan(
                                text: " " + "LABELINVENTORY".tr,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Single tapped.
                                    Get.to(() => InventoryScreen());
                                  },
                                style: TextStyle(
                                    color: UIColors.violet,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300)),
                          ]),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      visibilityInventary.value = !visibilityInventary.value
                    },
                    child: Icon(Icons.close_rounded,
                        color: UIColors.white.withOpacity(0.6)),
                  ),
                ],
              )),
        ));
  }
}
