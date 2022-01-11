import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';

import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryScreen extends StatelessWidget {
  bool isValueUpdated = false;
  RxList<UserInventory> _userInventory = RxList();
  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());

  updateStock(state, index, stocked) {
    UserInventory inv =
        _userInventory.where((el) => el.id == state.ingSearch[index].id).single;

    bool stock = stocked ? inv.stock = true : inv.stock = false;

    MenuController().updateStockCtrl(inv.id, stock);
    _userInventory.refresh();
  }

  setUserInventoryCheck(state, index) {
    if (_userInventory
        .where((el) => el.id == state.ingSearch[index].id)
        .isEmpty) {
      _userInventory.add(UserInventory(
          id: state.ingSearch[index].id,
          stock:
              state.userIngredients != null ? getStock(state, index) : false));
    }
  }

  bool getStock(state, index) {
    bool stock = false;
    for (var element in state.userIngredients) {
      if (element.id == state.ingSearch[index].id) {
        stock = element.stock;
      }
    }
    return stock;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    ingController.filterIngredients("");
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //if (mediaQuery.viewInsets.bottom == 0)
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("INVENTORY".tr,
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    CupertinoTextField(
                      padding: EdgeInsets.all(20),
                      onChanged: (text) {
                        ingController.filterIngredients(text);
                      },
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      placeholder: "TEXTFIELDLABELINVENTORY".tr,
                      placeholderStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color: UIColors.lightBlack.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.lightBlack.withOpacity(0.5)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => GetX<IngredientController>(
                            init: Get.put<IngredientController>(
                                IngredientController()),
                            builder: (IngredientController ingCtrl) {
                              if (ingCtrl.ingSearch.length > 0) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: ingCtrl.ingSearch.length,
                                    itemBuilder: (_, index) {
                                      setUserInventoryCheck(ingCtrl, index);
                                      return Obx(() => Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: UIColors.lightBlack,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: CheckboxListTile(
                                              checkColor: UIColors.green,
                                              activeColor: UIColors.green,
                                              title: Text(
                                                ingCtrl.ingSearch[index].name
                                                    .toString()
                                                    .toLowerCase(),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              value: getStock(ingCtrl, index),
                                              onChanged: (bool? value) {
                                                updateStock(
                                                    ingCtrl, index, value);
                                                isValueUpdated = true;
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing, //  <-- leading Checkbox
                                            ),
                                          ));
                                    },
                                  ),
                                );
                              } else {
                                //ingCtrl.filterIngredients("");
                                return LoadingWidget();
                              }
                            },
                          ))
                    ]),
              ),
            ),
            if (mediaQuery.viewInsets.bottom == 0)
              InkWell(
                onTap: () {
                  MenuController.instance.getMenuList(FilterBody.listFilters);
                  Get.back();
                },
                child: Container(
                  width: mediaQuery.size.height * 1,
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('DONE'.tr,
                        style: GoogleFonts.poppins(
                            color: UIColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
