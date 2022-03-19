import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/controllers/allergy_controller.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/home/Inventory_button_widget.dart';
import 'package:morning_brief/widgets/home/empty_menu.dart';
import 'package:morning_brief/widgets/home/label_info.dart';
import 'package:morning_brief/widgets/home/menu_tile.dart';
import 'package:morning_brief/widgets/spinner/spinner.dart';

// ignore: must_be_immutable
class HomeBody extends GetWidget<MenuController> {
  HomeBody({Key? key}) : super(key: key);

  IngredientController ingController =
      Get.put<IngredientController>(IngredientController());
  AllergyController allergyController =
      Get.put<AllergyController>(AllergyController());

  RxBool visibilityInventary = true.obs;
  RxBool visibility = true.obs;
  MenuController _menuController = MenuController.instance;
  @override
  Widget build(BuildContext context) {
    _menuController.getMenuList(FilterBody.listFilters);

    return Expanded(
      child: Container(
          child: Obx(() => (allergyController.userAllergies != null &&
                  ingController.ingredients != null)
              ? (_menuController.menus != null &&
                      _menuController.menus?.length == 0)
                  ? SingleChildScrollView(child: EmptyMenu())
                  : ListView(
                      controller: controller.scrollController,
                      children: <Widget>[
                        Container(
                          // height: 250,
                          margin: EdgeInsets.only(top: 0),
                          child: Center(
                              child: Column(
                            children: [
                              Inventory_button_widget(),
                              SizedBox(height: 5),
                              labelInfoInventory(
                                  visibilityInventary: visibilityInventary),
                              SizedBox(height: 5),
                              labelInfo(visibility: visibility),
                              SizedBox(height: 30),
                              headerBeforeCard(),
                            ],
                          )),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _menuController.menus?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: Obx(() => MenuTile(
                                      ingredients: ingController.ingredients,
                                      menu: _menuController.menus![index],
                                      savedMenu: false,
                                      isCookable:
                                          _menuController.userHasIngredients(
                                              _menuController.menus![index],
                                              ingController.userIngredients ??
                                                  []))));
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "LOADOTHERMENU".tr + ". ",
                                  style: GoogleFonts.poppins(
                                      color: UIColors.white.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                        text:
                                            controller.start.value.toString() +
                                                " / " +
                                                controller.maxLimit.toString(),
                                        style: GoogleFonts.poppins(
                                            color: UIColors.violet,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300)),
                                  ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        controller.isloading.value
                            ? LoadingWidgetSquareCircle()
                            : SizedBox(),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            showOtherButton(),
                          ],
                        ),*/
                      ],
                    )
              : LoadingWidget())),
    );
  }

  Widget showOtherButton() {
    return Obx(() => MenuController.instance.hasOtherMenuBool.value
        ? InkWell(
            onTap: () => {
              _menuController.incrementLimitMultiplier(),
              _menuController.getMenuList(FilterBody.listFilters),
              HapticFeedback.lightImpact(),
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.detailBlack,
              ),
              child: TextButton(
                onPressed: null,
                child: Text("LOADOTHERMENU".tr,
                    style: GoogleFonts.poppins(
                        color: UIColors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ),
            ),
          )
        : SizedBox());
  }

  Widget headerBeforeCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SCROLLFORMORE'.tr,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.6)),
          ),
          filtersIcon(),
        ],
      ),
    );
  }

  Widget filtersIcon() {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        Get.to(() => FiltersPage());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.filter_alt_outlined,
            color: UIColors.white,
          ),
          FilterBody.listFilters.length > 0
              ? Positioned(
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: UIColors.violetMain,
                  ),
                  top: -5,
                  right: -10,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
