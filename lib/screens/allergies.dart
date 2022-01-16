import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/global_input/time_eating_screen.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class AllergiesScreen extends GetWidget<AllergyController> {
  AllergiesScreen({Key? key, required this.isFirstLogin}) : super(key: key);
  final isFirstLogin;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Obx(() => GetX<AllergyController>(
        init: Get.put<AllergyController>(AllergyController()),
        builder: (controller) {
          if (controller.allergies != null) {
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
                                    Text("ALLERGENS".tr,
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.poppins(
                                            color: UIColors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    InkWell(
                                      onTap: () {
                                        controller.setAllergies(controller);

                                        MenuController.instance.getMenuList(
                                            FilterBody.listFilters);
                                        if (isFirstLogin)
                                          Get.to(() => TimeEatingScreen(
                                                isFirstLogin: isFirstLogin,
                                              ));
                                        else
                                          Get.back();
                                      },
                                      child: Text(
                                          isFirstLogin ? 'NEXT'.tr : 'DONE'.tr,
                                          style: GoogleFonts.poppins(
                                              color: UIColors.violet,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
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
                          child: Obx(() => GetX<AllergyController>(
                                init: Get.put<AllergyController>(
                                    AllergyController()),
                                builder: (AllergyController allergyController) {
                                  if (allergyController.allergies != null) {
                                    return Column(children: [
                                      Expanded(
                                          child: ListView.builder(
                                        itemCount: allergyController
                                                .allergies?.length ??
                                            0,
                                        itemBuilder: (_, index) {
                                          //return Text(allergyController.allergies![index].name);
                                          controller.setAllergiesCheck(
                                              allergyController, index);
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
                                                  controller.getAllergyName(
                                                      allergyController, index),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                value: controller.getCheckValue(
                                                    allergyController, index),
                                                onChanged: (newValue) {
                                                  controller.setCheckState(
                                                      allergyController,
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
                                      )),
                                    ]);
                                  } else {
                                    return LoadingWidget();
                                  }
                                },
                              )),
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
