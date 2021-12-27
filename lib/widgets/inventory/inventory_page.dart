import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/userInventory_model.dart';

import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryScreen extends GetWidget<IngredientController> {
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
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (mediaQuery.viewInsets.bottom == 0)
              Flexible(
                  flex: 1,
                  child: ArrowHeader(
                    home: true,
                  )),
            if (mediaQuery.viewInsets.bottom == 0)
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("INGREDIENTSINVENTORY".tr,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.poppins(
                                    color: UIColors.white,
                                    fontSize: 31,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("INGREDIENTSINVENTORYSUBTITLE".tr,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.poppins(
                                    color: UIColors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: UIColors.white,
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: UIColors.detailBlack,
                    ),
                  ),
                  onChanged: (text) {
                    ingController.filterIngredients(text);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.detailBlack),
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
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                            ),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                right: 20,
                                                left: 20),
                                            decoration: BoxDecoration(
                                                color: UIColors.black
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 3,
                                                  child: Text(
                                                    ingCtrl
                                                        .ingSearch[index].name
                                                        .toString()
                                                        .toLowerCase(),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: GoogleFonts.poppins(
                                                        color: UIColors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: Checkbox(
                                                    side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.5,
                                                    ),
                                                    checkColor:
                                                        UIColors.darkPurple,
                                                    focusColor:
                                                        UIColors.darkPurple,
                                                    activeColor:
                                                        UIColors.darkPurple,
                                                    value: getStock(
                                                        ingCtrl, index),
                                                    onChanged: (bool? value) {
                                                      updateStock(ingCtrl,
                                                          index, value);
                                                    },
                                                  ),
                                                )
                                              ],
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
          ],
        ),
      ),
    );
  }
}
