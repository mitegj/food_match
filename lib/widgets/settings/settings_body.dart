import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/screens/allergies.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 6,
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.detailBlack),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Dati personali',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => AllergiesScreen());
                      },
                      child: Text(
                        'Allergie',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Support us with 5 star',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () async {
                        final url = Uri.encodeFull(
                            'mailto:beyondx.team@gmail.com?subject=Feedback&body=');
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          Get.snackbar(
                            "Errore durante l'apertura dell'app Mail",
                            'Impossibile eseguire $url',
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Text(
                        'Help and assistence',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: UIColors.black,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Privacy policy',
                        style: GoogleFonts.poppins(
                          color: UIColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: mediaQuery.size.width * 1,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: UIColors.lightBlack.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                // TODO: Logout da google
                AuthController().logoutGoogle();
              },
              child: Text(
                'Disconetti account',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Cancella account',
                  style: GoogleFonts.poppins(
                    color: theme.secondaryHeaderColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              (' 0.0.1').toLowerCase(),
              style: GoogleFonts.poppins(
                color: theme.secondaryHeaderColor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
