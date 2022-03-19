import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/menu_controller.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/filter/filters_body.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';

class FiltersPage extends StatelessWidget {
  FiltersPage({Key? key}) : super(key: key);

  static RxBool getAllMenus = true.obs;

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
                    const SizedBox(height: 20),
                    Flexible(
                      flex: 1,
                      child: Text("ANYPREFERENCES".tr + "?",
                          style: GoogleFonts.poppins(
                              color: UIColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: Text("DOYOUWHANTALLMENU".tr,
                                style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300))),
                        Obx(
                          () => Switch(
                            activeColor: UIColors.green,
                            value: getAllMenus.value,
                            onChanged: (value) {
                              getAllMenus.toggle();
                              MenuController.instance
                                  .getMenuList(FilterBody.listFilters);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          FilterBody()
        ])));
  }
}
