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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (mediaQuery.viewInsets.bottom == 0)
              Flexible(flex: 1, child: ArrowHeader()),
            if (mediaQuery.viewInsets.bottom == 0)
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text("Gestisci il tuo inventario personale",
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
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
                  controller.filterIngredients(text);
                },
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 20, right: 20),
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
                                  child: Container(
                                      child: ListView.builder(
                                    itemCount: ingCtrl.ingSearch.length,
                                    itemBuilder: (_, index) {
                                      setUserInventoryCheck(ingCtrl, index);
                                      return Obx(() => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      ingCtrl.ingSearch[index]
                                                          .listName
                                                          .toString()
                                                          .toLowerCase(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: UIColors
                                                                  .white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.5,
                                                    ),
                                                    checkColor: UIColors.green,
                                                    focusColor: UIColors.green,
                                                    activeColor: UIColors.green,
                                                    value: getStock(
                                                        ingCtrl, index),
                                                    onChanged: (bool? value) {
                                                      updateStock(ingCtrl,
                                                          index, value);
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ));
                                    },
                                  )),
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
