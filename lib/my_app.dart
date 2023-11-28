import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import 'core/utils/helpers/app_themes.dart';
import 'core/utils/helpers/languages/app_constants.dart';
import 'core/utils/helpers/languages/localization_controller.dart';
import 'core/utils/helpers/languages/messages.dart';
import 'presentation/screens/splashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ThemeProvider(
            defaultThemeId: 'brown',
            saveThemesOnChange: true,
            loadThemeOnInit: false,
            onInitCallback: (controller, previouslySavedThemeFuture) async {
              String? savedTheme = await previouslySavedThemeFuture;
              if (savedTheme != null) {
                controller.setTheme(savedTheme);
              } else {
                Brightness platformBrightness = SchedulerBinding
                        .instance.platformDispatcher.platformBrightness ??
                    Brightness.light;
                if (platformBrightness == Brightness.dark) {
                  controller.setTheme('dark');
                } else {
                  controller.setTheme('brown');
                }
                controller.forgetSavedTheme();
              }
            },
            themes: AppThemes.list,
            child: ThemeConsumer(
              child: Builder(builder: (themeContext) {
                return GetBuilder<LocalizationController>(
                    builder: (localizationController) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Sunti',
                    locale: localizationController.locale,
                    translations: Messages(languages: languages),
                    fallbackLocale: Locale(
                        AppConstants.languages[0].languageCode,
                        AppConstants.languages[0].countryCode),
                    theme: ThemeProvider.themeOf(themeContext).data,
                    home: const Directionality(
                      textDirection: TextDirection.rtl,
                      child: SplashScreen(),
                    ),
                  );
                });
              }),
            ),
          );
        });
  }
}
