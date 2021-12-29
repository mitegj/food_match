import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class AllergiesScreen extends GetWidget<AllergyController> {
  AllergiesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 50),
                            child: Column(
                              children: [
                                Text("ANYALLERGY".tr + "?",
                                    style: GoogleFonts.poppins(
                                        color: UIColors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 20),
                                Text("DECLAREYOURALLERGIES".tr,
                                    style: GoogleFonts.poppins(
                                        color: UIColors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(20),
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
                      InkWell(
                        onTap: () {
                          controller.setAllergies(controller);
                        },
                        child: Container(
                          width: mediaQuery.size.height * 1,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                              color: UIColors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('DONE'.tr,
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                    ])));
          } else {
            return LoadingWidget();
          }
        }));
  }
}
