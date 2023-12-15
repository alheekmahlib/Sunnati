import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:sunti/presentation/screens/splashScreen/widgets/splash_title.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import '/core/utils/constants/extensions.dart';
import '/presentation/controllers/ourApps_controller.dart';
import '/presentation/screens/ourApp/widgets/our_apps_build.dart';

class OurApps extends StatelessWidget {
  const OurApps({super.key});

  @override
  Widget build(BuildContext context) {
    sl<OurAppsController>().fetchApps();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).id == 'dark'
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).canvasColor,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: orientation(
              context,
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: container(
                      context,
                      const OurAppsBuild(),
                      false,
                      height: orientation(context, 450.0.h, 300.0.h),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                          offset: orientation(
                              context, Offset(0, -200.h), Offset(0, -130.h)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              sunti_logo(
                                context,
                                width: 80.0.w,
                              ),
                              const Gap(16),
                              const SplashTitle(),
                            ],
                          ))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48.0).r,
                      child: alheekmah_logo(context,
                          width: 80.w, color: context.surfaceDarkColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 48.0, right: 16.0).r,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: arrow_back(
                            context,
                            width: 26,
                            color: context.surfaceDarkColor,
                          ),
                        )),
                  ),
                ],
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: arrow_back(
                                      context,
                                      width: 26,
                                      color: context.surfaceDarkColor,
                                    ),
                                  )),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                sunti_logo(
                                  context,
                                  width: 80.0,
                                ),
                                const Gap(16),
                                const SplashTitle(),
                              ],
                            ),
                            const Gap(64),
                            alheekmah_logo(
                              context,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: whiteContainer(
                          context,
                          const OurAppsBuild(),
                          height: 300.0,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
