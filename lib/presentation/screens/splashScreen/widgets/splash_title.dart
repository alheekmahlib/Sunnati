import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../controllers/splashScreen_controller.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        height: 70,
        width: sl<SplashScreenController>().animate.value ? 300 : 10,
        duration: const Duration(milliseconds: 600),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          decoration: const BoxDecoration(
              color: Color(0xffE6DAC8),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
                color: Color(0xffF7F1EC),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Obx(
              () => AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: sl<SplashScreenController>().animate.value ? 1 : 0,
                child: const Center(
                  child: Text(
                    'فعليكم بسُنَّتي وسُنَّةِ الخُلَفاءِ الرَّاشِدينَ المَهْدِيِّينَ',
                    style: TextStyle(
                        fontFamily: 'kufi',
                        color: Color(0xff3C2A21),
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
