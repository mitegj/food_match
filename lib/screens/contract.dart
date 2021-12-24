import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/widgets/global_input/arrow_header.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top:20,right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text("Terms and conditions",
                              style: GoogleFonts.poppins(
                                  color: UIColors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Row(
                          children: [
                            Text("Your agreement",
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
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam cursus, odio in pellentesque tempor, velit nibh suscipit massa, non iaculis urna massa id nibh. Ut a arcu venenatis, placerat libero luctus, mattis tellus. Suspendisse ultrices nisl sapien, quis consectetur velit condimentum et. Donec euismod felis a augue laoreet, sed eleifend leo porta. Pellentesque consectetur, leo sit amet ornare maximus, magna arcu finibus justo, vel consectetur orci lectus nec nisl. Aenean consequat ac tortor et tristique. Maecenas commodo ex auctor faucibus sagittis. Sed at tempor lectus. Praesent sollicitudin, sapien a faucibus faucibus, nisl ex aliquet justo, ac efficitur leo quam quis sem. Praesent lobortis eu ligula sit amet sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras convallis, purus non imperdiet ultrices, felis nisl iaculis odio, in consequat nunc purus in sem. Quisque congue, lacus sit amet rhoncus pulvinar, mauris ligula varius tortor, sed feugiat ligula nunc in mi"
                                  "Donec vulputate faucibus metus, lobortis commodo sapien consectetur non. Maecenas venenatis quis neque id interdum. In dolor nunc, sollicitudin lobortis sapien lobortis, faucibus eleifend sapien. Nullam et ultrices ipsum. Vestibulum lacus massa, luctus nec ornare nec, aliquet sed nibh. Aliquam pretium ante quis ipsum laoreet facilisis. Nulla aliquet molestie sapien, sit amet scelerisque mi mollis non. Praesent congue gravida turpis quis laoreet.",
                                  style: TextStyle(
                                    color: UIColors.white.withOpacity(0.8)
                                  ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ])));
  }
}
