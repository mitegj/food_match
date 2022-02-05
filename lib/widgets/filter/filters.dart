import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';

class FiltersPage extends StatelessWidget {
  FiltersPage({Key? key}) : super(key: key);

  static RxBool getAllMenus = false.obs;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ArrowHeader(),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text("ANYPREFERENCES".tr + "?",
                            style: GoogleFonts.poppins(
                                color: UIColors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        checkColor: UIColors.green,
                        activeColor: UIColors.green,
                        title: Text(
                          "DOYOUWHANTALLMENU".tr,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        value: getAllMenus.value,

                        onChanged: (newValue) {
                          getAllMenus.value = !getAllMenus.value;

                          MenuController.instance
                              .getMenuList(FilterBody.listFilters);
                        },
                        controlAffinity: ListTileControlAffinity
                            .trailing, //  <-- leading Checkbox
                      ),
                    )
                  ],
                ),
              )),
          FilterBody()
        ])));
  }
}
