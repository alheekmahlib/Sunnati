import 'dart:ui';

import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/services/shared_pref_services.dart';

class SettingsController extends GetxController {
  Locale? initialLang;
  RxString languageFont = 'naskh'.obs;
  // RxString languageFont2 = 'kufi'.obs;
  RxBool settingsSelected = false.obs;

  void setLocale(Locale value) {
    initialLang = value;
    update();
  }

  Future<void> loadLang() async {
    String? langCode = await sl<SharedPrefServices>().getString("lang");
    String? langFont = await sl<SharedPrefServices>().getString("languageFont");
    // String? langFont2 =
    //     await sl<SharedPrefServices>().getString("languageFont2");

    print(
        'Lang code: $langCode'); // Add this line to debug the value of langCode

    if (langCode.isEmpty) {
      initialLang = const Locale('ar', 'AE');
    } else {
      initialLang = Locale(
          langCode, ''); // Make sure langCode is not null or invalid here
    }

    languageFont.value = langFont;
    // languageFont2.value = langFont2;

    print('get lang $initialLang');
  }

  List languageList = [
    {
      'lang': 'ar',
      'appLang': 'لغة التطبيق',
      'name': 'العربية',
      'font': 'naskh',
      'font2': 'kufi'
    },
    {
      'lang': 'en',
      'appLang': 'App Language',
      'name': 'English',
      'font': 'naskh',
      'font2': 'naskh'
    },
    {
      'lang': 'bn',
      'appLang': 'অ্যাপের ভাষা',
      'name': 'বাংলা',
      'font': 'bn',
      'font2': 'bn'
    },
    {
      'lang': 'ur',
      'appLang': 'ایپ کی زبان',
      'name': 'اردو',
      'font': 'urdu',
      'font2': 'urdu'
    },
    // {
    //   'lang': 'es',
    //   'appLang': 'Idioma de la aplicación',
    //   'name': 'Español',
    //   'font': 'naskh',
    //   'font2': 'naskh'
    // },

    // {
    //   'lang': 'so',
    //   'appLang': 'Luqadda Appka',
    //   'name': 'Soomaali',
    //   'font': 'naskh'
    // },
  ];
}
