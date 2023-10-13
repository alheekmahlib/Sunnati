import 'dart:io' show Platform;

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../features/books/data/models/bookmark_model.dart';
import '../utils/constants/assets_data.dart';
import '../utils/helpers/ui_helper.dart';
import 'controllers/bookmark_controller.dart';
import 'controllers/general_controller.dart';
import 'controllers/searchController.dart';
import 'controllers/settings_controller.dart';
import 'controllers/splashScreen_controller.dart';
import 'shared_pref_services.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void initSingleton() {
    sl<SharedPrefServices>();
  }

  Future<void> _initPrefs() async =>
      await SharedPreferences.getInstance().then((v) {
        sl.registerSingleton<SharedPreferences>(v);
        sl.registerSingleton<SharedPrefServices>(SharedPrefServices(v));
      });

  Future<void> setupHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookmarkAdapter());
    await Hive.openBox<Bookmark>(AssetsData.bookmarkBox);
  }

  Future<void> init() async {
    await Future.wait([
      _initPrefs(),
      setupHive(),
    ]);

    // Controllers
    sl.registerLazySingleton<GeneralController>(
        () => Get.put<GeneralController>(GeneralController(), permanent: true));

    sl.registerLazySingleton<SettingsController>(() =>
        Get.put<SettingsController>(SettingsController(), permanent: true));

    sl.registerLazySingleton<SearchControllers>(
        () => Get.put<SearchControllers>(SearchControllers(), permanent: true));

    sl.registerLazySingleton<BookmarkController>(() =>
        Get.put<BookmarkController>(BookmarkController(), permanent: true));

    sl.registerLazySingleton<SplashScreenController>(() =>
        Get.put<SplashScreenController>(SplashScreenController(),
            permanent: true));

    UiHelper.rateMyApp.init();

    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
    }
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      await DesktopWindow.setMinWindowSize(const Size(900, 840));
    }
  }
}
