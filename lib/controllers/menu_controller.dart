import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/controllers/ingredient_controller.dart';
import 'package:morning_brief/enum/dish_type_enum.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/services/menu_database.dart';
import 'package:morning_brief/widgets/home/confirm_cooked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<List<MenuModel>> menuList = Rxn<List<MenuModel>>().obs();
  List<MenuModel>? get menus => menuList.value.obs();
  int limit = 30;
  set menus(List<MenuModel>? value) {
    menus?.clear();
  }

  IngredientController? _ingController;

  MenuController();
  MenuController.fromCtrl(IngredientController ingController)
      : _ingController = ingController;

  @override
  void onInit() {
    super.onInit();
    // getMenuList();
  }

  RxList<int> getAllFilters() {
    // se i filtri sono vuoti li aggiungo tutti
    RxList<int> fl = RxList<int>();

    DishType.values.forEach((el) {
      fl.add(el.index);
    });

    return fl;
  }

  getMenuList(RxList<int> filters) {
    if (filters.length == 0) {
      filters = getAllFilters();
    }
    menuList
        .bindStream(DatabaseMenu().menuStream(_ingController, filters, limit));
  }

  Future<void> updateStockCtrl(String uid, bool stock) async {
    try {
      if (await DatabaseMenu().updateInventory(uid, stock)) {
        //Get.back();

      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateSavedMenu(MenuModel menu) async {
    try {
      if (await DatabaseMenu().updateCookedMenu(menu)) {
        Get.to(() => ConfirmCooked(
              cooked: true,
            ));
      }
    } catch (e) {
      Get.snackbar(
        "Error saving menu",
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  checkBeforeSaveMenu(MenuModel menu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastTimeCookedS = "";
    int lastCookingTime = 0;
    (prefs.getString('lastTimeCooked') != null)
        ? lastTimeCookedS = prefs.getString('lastTimeCooked')!
        : lastTimeCookedS = DateTime(0).toString();
    prefs.getInt('lastCookingTime') != null
        ? lastCookingTime = prefs.getInt('lastCookingTime')!
        : lastCookingTime = 0;

    DateTime lastTimeCooked = DateTime.parse(lastTimeCookedS);
    if (DateTime.now().difference(lastTimeCooked).inMinutes < lastCookingTime) {
      Get.to(() => ConfirmCooked(cooked: false));
    } else {
      updateSavedMenu(menu).then(
        (_) => prefs.setInt("lastCookingTime", menu.preparationTime).then((_) =>
            prefs.setString('lastTimeCooked', DateTime.now().toString())),
      );
    }
  }

  String getIngredientName(String id, ingredients) {
    var ing = ingredients!.where((el) => el.id == id);
    return (ing.length == 0)
        ? ""
        : ingredients!.where((el) => el.id == id).single.name;
  }

  /*

  Future<String> getPhoto(String query) async {
    List<String> args = [];
    // Load app credentials from environment variables or file.
    var appCredentials = loadAppCredentialsFromEnv();

    if (appCredentials == null) {
      if (args.length != 1) {
        throw 'Please provide a credentials file as the first and only argument.';
      }

      appCredentials = await loadAppCredentialsFromFile(args.first);
    }

    // Create a client.
    final client = UnsplashClient(
      settings: ClientSettings(credentials: appCredentials),
    );

    // Fetch 5 random photos by calling `goAndGet` to execute the [Request]
    // returned from `random` and throw an exception if the [Response] is not ok.

    final photos =
        await client.photos.random(query: query, count: 1).goAndGet();
    // Do something with the photos.
    //print('--- Photos');
    print(photos);
    // print('---\n');

    // Create a dynamically resizing url.
    final resizedUrl = photos.first.urls.raw.resizePhoto(
      fit: ResizeFitMode.clamp,
      format: ImageFormat.webp,
    );
    print('--- Resized Url');
    print(resizedUrl);

    client.close();
    return resizedUrl.toString();
    //return "https://images.unsplash.com/photo-1505253716362-afaea1d3d1af?ixid=MnwyODYwOTl8MHwxfHNlYXJjaHwxfHxjYW5uZWQlMjBmZW5uZWwlMjBhbmQlMjBtYWNrZXJlbCUyMHNhbGFkfGVufDB8fHx8MTY0MDUzOTIzMQ\u0026ixlib=rb-1.2.1";
    // Close the client when it is done being used to clean up allocated
    // resources.
  }

  AppCredentials? loadAppCredentialsFromEnv() {
    final accessKey = 'WXaaTaOr7onqDfzRNagCCygC_EQhzE6YzGlOnOCbFu4';
    final secretKey = 'CxxKDcehW92nksFWvOJOqLZ5QC1X_1m0egZjTDkzAtU';

    return AppCredentials(
      accessKey: accessKey,
      secretKey: secretKey,
    );
  }

  /// Loads [AppCredentials] from a json file with the given [fileName].
  Future<AppCredentials> loadAppCredentialsFromFile(String fileName) async {
    final file = File(fileName);
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return AppCredentials.fromJson(json);
  }
  */
}
