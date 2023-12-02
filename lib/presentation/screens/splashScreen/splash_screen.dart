import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../controllers/splashScreen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<SplashScreenController>().startTime();
    return Scaffold(
      backgroundColor: const Color(0xffF7F1EC),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: sunti_iconR(context, width: 100),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -40),
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.sizeOf(context).width,
                              color: const Color(0xffE6DAC8),
                            ),
                            Container(
                              height: 10,
                              width: MediaQuery.sizeOf(context).width,
                              margin: const EdgeInsets.only(top: 8.0),
                              color: const Color(0xffF7F1EC),
                            ),
                          ],
                        ),
                      ),
                      sunti_logo(
                        context,
                        height: 100,
                        width: 100,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => AnimatedContainer(
                      height: 70,
                      width:
                          sl<SplashScreenController>().animate.value ? 300 : 10,
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 2.0),
                        decoration: const BoxDecoration(
                            color: Color(0xffE6DAC8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          decoration: const BoxDecoration(
                              color: Color(0xffF7F1EC),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              )),
                          alignment: Alignment.center,
                          child: Obx(
                            () => AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity:
                                  sl<SplashScreenController>().animate.value
                                      ? 1
                                      : 0,
                              child: const Text(
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      alheekmah_logo(
                        context,
                        width: 90,
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: Transform.translate(
                            offset: const Offset(0, -25),
                            child: loading(width: 125.0)),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
