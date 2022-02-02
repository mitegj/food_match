import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryScreen extends GetWidget<IngredientController> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Obx(() => GetX<IngredientController>(
        init: Get.put<IngredientController>(IngredientController()),
        builder: (controller) {
          if (controller.ingredients != null) {
            return Scaffold(
                backgroundColor: theme.backgroundColor,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("INVENTORY".tr,
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.poppins(
                                            color: UIColors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          color: UIColors.detailBlack,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: TextButton(
                                        child: Text('DONE'.tr.toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                color: UIColors.violet,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                        onPressed: () {
                                          controller.setIngredients(controller);
                                          HapticFeedback.mediumImpact();
                                          Get.back();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                              color: UIColors.lightBlack.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView(children: [
                            CupertinoSearchTextField(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, right: 20, left: 10),
                              onChanged: (text) {
                                controller.filterIngredients(controller, text);
                              },
                              autofocus: false,
                              style: GoogleFonts.poppins(
                                  color: UIColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              itemSize: 30,
                              placeholder: 'TEXTFIELDLABELINVENTORY'.tr,
                              prefixInsets: EdgeInsets.only(left: 20),
                              suffixInsets: EdgeInsets.only(right: 20),
                              itemColor: UIColors.violet,
                              placeholderStyle: GoogleFonts.poppins(
                                  color: UIColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              decoration: BoxDecoration(
                                color: UIColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => GetX<IngredientController>(
                                  init: Get.put<IngredientController>(
                                      IngredientController()),
                                  builder: (IngredientController
                                      ingredientController) {
                                    if (ingredientController.ingredients !=
                                        null) {
                                      return Column(children: [
                                        ListView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: ingredientController
                                              .ingSearch.length,
                                          itemBuilder: (_, index) {
                                            controller.setIngredientsCheck(
                                                ingredientController, index);
                                            return Obx(
                                              () => Container(
                                                margin: EdgeInsets.all(5),
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: UIColors.lightBlack,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: CheckboxListTile(
                                                  checkColor: UIColors.green,
                                                  activeColor: UIColors.green,
                                                  title: Text(
                                                    controller.getIngredientName(
                                                        ingredientController,
                                                        index),
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  value:
                                                      controller.getCheckValue(
                                                          ingredientController,
                                                          index),

                                                  subtitle: Text(
                                                      controller.getCheckValue(
                                                              ingredientController,
                                                              index)
                                                          ? "AVAIBLEINTHEKITCHEN"
                                                              .tr
                                                              .toLowerCase()
                                                          : "NOTAVAIBLEINTHEKITCHEN"
                                                              .tr
                                                              .toLowerCase(),
                                                      style: GoogleFonts.poppins(
                                                          color: controller
                                                                  .getCheckValue(
                                                                      ingredientController,
                                                                      index)
                                                              ? UIColors
                                                                  .lightGreen
                                                              : UIColors.orange,
                                                          fontWeight:
                                                              FontWeight.w300)),

                                                  onChanged: (newValue) {
                                                    controller.setCheckState(
                                                        ingredientController,
                                                        index,
                                                        newValue);
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing, //  <-- leading Checkbox
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ]);
                                    } else {
                                      return LoadingWidget();
                                    }
                                  },
                                )),
                          ]),
                        ),
                      ),
                    ])));
          } else {
            return Scaffold(
                backgroundColor: UIColors.black, body: LoadingWidget());
          }
        }));
  }
}
