import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/userInventory_model.dart';

import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/home/filters_body.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryScreen extends StatelessWidget {
  bool isValueUpdated = false;
  RxList<UserInventory> _userInventory = RxList();
  IngredientController ingController = Get.find<IngredientController>();

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
            if (mediaQuery.viewInsets.bottom == 0)
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("INGREDIENTSINVENTORYSUBTITLE".tr + ":",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: UIColors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(20),
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
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                color: UIColors.lightBlack,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 3,
                                                  child: CheckboxListTile(
                                                    checkColor: UIColors.green,
                                                    activeColor: UIColors.green,

                                                    title: Text(
                                                      ingCtrl
                                                          .ingSearch[index].name
                                                          .toString()
                                                          .toLowerCase(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                    value: getStock(
                                                        ingCtrl, index),
                                                    onChanged: (bool? value) {
                                                      updateStock(ingCtrl,
                                                          index, value);
                                                      isValueUpdated = true;
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .trailing, //  <-- leading Checkbox
                                                  ),
                                                ),
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
            InkWell(
              onTap: () {
                MenuController.instance.getMenuList(FilterBody.listFilters);
                Get.back();
              },
              child: Container(
                width: mediaQuery.size.height * 1,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
          ],
        ),
      ),
    );
  }
}
