import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:get/get.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({Key? key}) : super(key: key);

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
              child: Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text("TERMSANDCONDITIONS".tr,
                      style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
                Row(
                  children: [
                    Text("YOURAGREEMENT".tr,
                        style: GoogleFonts.poppins(
                            color: UIColors.pink,
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam cursus, odio in pellentesque tempor, velit nibh suscipit massa, non iaculis urna massa id nibh. Ut a arcu venenatis, placerat libero luctus, mattis tellus. Suspendisse ultrices nisl sapien, quis consectetur velit condimentum et. Donec euismod felis a augue laoreet, sed eleifend leo porta. Pellentesque consectetur, leo sit amet ornare maximus, magna arcu finibus justo, vel consectetur orci lectus nec nisl. Aenean consequat ac tortor et tristique. Maecenas commodo ex auctor faucibus sagittis. Sed at tempor lectus. Praesent sollicitudin, sapien a faucibus faucibus, nisl ex aliquet justo, ac efficitur leo quam quis sem. Praesent lobortis eu ligula sit amet sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras convallis, purus non imperdiet ultrices, felis nisl iaculis odio, in consequat nunc purus in sem. Quisque congue, lacus sit amet rhoncus pulvinar, mauris ligula varius tortor, sed feugiat ligula nunc in mi",
                        style:
                            TextStyle(color: UIColors.white.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Icon(
                            Icons.exit_to_app,
                            size: 25,
                            color: UIColors.detailBlack,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'HAVEREAD'.tr,
                              style: GoogleFonts.poppins(
                                  color: UIColors.detailBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ])));
  }
}
