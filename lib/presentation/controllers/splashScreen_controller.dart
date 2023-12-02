import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../screens/main/main_screen.dart';

class SplashScreenController extends GetxController {
  RxBool animate = false.obs;

  Future startTime() async {
    await Future.delayed(const Duration(seconds: 1));
    animate.value = true;
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const MainScreen(),
        transition: Transition.downToUp,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut);
  }
}
