import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sunti/core/widgets/widgets.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../controllers/splashScreen_controller.dart';
import 'widgets/alheekmah_and_loading.dart';
import 'widgets/splash_title.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<SplashScreenController>().startTime();
    return Scaffold(
      backgroundColor: const Color(0xffF7F1EC),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: orientation(
            context,
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, -120),
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
                Align(
                  alignment: Alignment.topRight,
                  child: sunti_iconR(context, width: 100),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sunti_logo(
                      context,
                      height: 100,
                      width: 100,
                    ),
                    const Gap(32),
                    const SplashTitle(),
                  ],
                ),
                const AlheekmahAndLoading()
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: const Offset(0, 40),
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
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: sunti_iconR(context, width: 100),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: const Offset(0, -20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 3,
                            child: sunti_logo(
                              context,
                              height: 100,
                              width: 100,
                            )),
                        const Expanded(flex: 7, child: SplashTitle()),
                      ],
                    ),
                  ),
                ),
                const AlheekmahAndLoading()
              ],
            )),
      ),
    );
  }
}
