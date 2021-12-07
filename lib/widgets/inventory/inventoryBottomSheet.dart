import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/models/userInventory_model.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class InventoryBottomSheet extends StatelessWidget {
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
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.845,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: UIColors.blue),
      child: Column(children: [
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 60,
                        child: Divider(
                            height: 5, color: UIColors.black, thickness: 4)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: UIColors.bluelight,
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (text) {
                          ingController.filterIngredients(text);
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 0, bottom: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  ingCtrl
                                                      .ingSearch[index].listName
                                                      .toString()
                                                      .toLowerCase(),
                                                  style: GoogleFonts.poppins(
                                                      color: UIColors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                                checkColor: UIColors.pink,
                                                focusColor: UIColors.pink,
                                                activeColor: UIColors.pink,
                                                value: getStock(ingCtrl, index),
                                                onChanged: (bool? value) {
                                                  updateStock(
                                                      ingCtrl, index, value);
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
                      )),
                ],
              ),
            ))
      ]),
    );
  }
}
