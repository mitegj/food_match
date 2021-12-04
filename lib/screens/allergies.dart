import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/models/allergyChecked_model.dart';
import 'package:morning_brief/screens/homepage.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

class AllergiesScreen extends GetWidget<AllergyController> {
  AllergiesScreen({Key? key}) : super(key: key);

  RxList<AllergyChecked> _isChecked = RxList();

  //RxList<String> allergies = RxList();
  bool isValueUpdated = false;

  setAllergies(allergyController) {
    if (isValueUpdated) {
      allergyController
          .updateAllergies(_isChecked)
          .then((value) => Get.off(() => HomePage()));
    } else {
      Get.off(() => HomePage());
    }
  }

  getAllergyName(allergyController, index) {
    return allergyController.allergies![index].name.toString();
  }

  getCheckValue(allergyController, index) {
    return _isChecked
        .where((el) => el.id == allergyController.allergies![index].id)
        .single
        .checked;
  }

  setCheckState(state, index, newValue) {
    _isChecked
        .where((el) => el.id == state.allergies[index].id)
        .single
        .checked = newValue!;

    _isChecked.refresh();

    if (!isValueUpdated) {
      isValueUpdated = true;
    }
  }

  setAllergiesCheck(state, index) {
    if (_isChecked.where((el) => el.id == state.allergies[index].id).isEmpty) {
      _isChecked.add(AllergyChecked(
          id: state.allergies[index].id,
          checked: state.userAllergies != null
              ? state.userAllergies.contains(state.allergies[index].id)
              : false));
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Obx(() => GetX<AllergyController>(
        init: Get.put<AllergyController>(AllergyController()),
        builder: (AllergyController allergyController) {
          if (allergyController.allergies != null) {
            return Scaffold(
                backgroundColor: theme.backgroundColor,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Expanded(
                          child: Container(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 50),
                        child: Column(
                          children: [
                            Text("Do you have any kind of allergies?",
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 20),
                            Text(
                                "Declare them and we will not show you recipes wich contains those",
                                style: GoogleFonts.poppins(
                                    color: UIColors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      )),
                      Expanded(
                        flex: 2,
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
                                          setAllergiesCheck(
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
                                                  getAllergyName(
                                                      allergyController, index),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                value: getCheckValue(
                                                    allergyController, index),
                                                onChanged: (newValue) {
                                                  setCheckState(
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
                                    return const Text("Loading data...");
                                  }
                                },
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setAllergies(allergyController);
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
                            child: Text('Done',
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
