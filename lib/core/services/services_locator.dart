import 'dart:developer' show log;
import 'dart:io' show Platform;

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../presentation/controllers/bookmark_controller.dart';
import '../../presentation/controllers/books_controller.dart';
import '../../presentation/controllers/general_controller.dart';
import '../../presentation/controllers/onboarding_controller.dart';
import '../../presentation/controllers/ourApps_controller.dart';
import '../../presentation/controllers/search_controller.dart';
import '../../presentation/controllers/settings_controller.dart';
import '../../presentation/controllers/share_controller.dart';
import '../../presentation/controllers/splashScreen_controller.dart';
import '../../presentation/screens/books/data/models/ar_hadith_model.dart';
import '../../presentation/screens/books/data/models/bn_hadith_model.dart';
import '../../presentation/screens/books/data/models/bookmark_model.dart';
import '../../presentation/screens/books/data/models/en_hadith_model.dart';
import '../../presentation/screens/books/data/models/ur_hadith_model.dart';
import '../utils/constants/assets_data.dart';
import '../utils/constants/enums.dart';
import '../utils/helpers/ui_helper.dart';
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

  Future<void> _initHive() async {
    try {
      await Hive.initFlutter();

      Hive.registerAdapter(BookmarkAdapter());
      await Hive.openBox<Bookmark>(AssetsData.bookmarkBox);

      for (var author in Authors.values) {
        // authors hadiths in ar
        await Hive.openLazyBox<List<ARHadithModel>>('${author.name}_ar');
        // authors hadiths in en
        await Hive.openLazyBox<List<ENHadithModel>>('${author.name}_en');
        // authors hadiths in ur
        await Hive.openLazyBox<List<URHadithModel>>('${author.name}_ur');
        // authors hadiths in bn
        await Hive.openLazyBox<List<BNHadithModel>>('${author.name}_bn');
      }

      log('Hive initilized successfully');
    } catch (e) {
      log('$e');
    }
  }

  Future<void> init() async {
    await Future.wait([
      _initHive(),
      _initPrefs(),
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

    sl.registerLazySingleton<OnboardingController>(() =>
        Get.put<OnboardingController>(OnboardingController(), permanent: true));

    sl.registerLazySingleton<OurAppsController>(
        () => Get.put<OurAppsController>(OurAppsController(), permanent: true));

    sl.registerLazySingleton<ShareController>(
        () => Get.put<ShareController>(ShareController(), permanent: true));

    sl.registerSingleton<BooksController>(
        Get.put<BooksController>(BooksController(), permanent: true));

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
