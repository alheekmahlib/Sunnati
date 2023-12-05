import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/widgets.dart';
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
        child: beigeContainer(
          context,
          whiteContainer(
            context,
            Obx(
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
