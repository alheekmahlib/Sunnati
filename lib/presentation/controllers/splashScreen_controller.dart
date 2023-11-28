import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/main/main_screen.dart';

class SplashScreenController extends GetxController {
  RxBool animate = false.obs;

  Future startTime() async {
    await Future.delayed(const Duration(seconds: 1));
    animate.value = true;
    await Future.delayed(const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigationPage();
    });
  }

  Future<void> navigationPage() async {
    if (sl<SharedPreferences>().getBool(IS_FIRST_TIME) == null) {
      // Get.off(() => const OnboardingScreen());
      sl<SharedPreferences>().setBool(IS_FIRST_TIME, false);
    } else {
      Get.off(() => const MainScreen());
    }
  }
}
