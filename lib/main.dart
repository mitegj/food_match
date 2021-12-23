import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/auth_controller.dart';
import 'package:morning_brief/controllers/bindings/authBind.dart';
import 'package:morning_brief/dictionary/dictionary.dart';
import 'package:morning_brief/utils/UIColors.dart';
import 'package:morning_brief/utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.deepPurple, // navigation bar color
    statusBarColor: Colors.pink, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.deepPurple, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        backgroundColor: UIColors.black,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      home: Root(),
    );
  }
}
