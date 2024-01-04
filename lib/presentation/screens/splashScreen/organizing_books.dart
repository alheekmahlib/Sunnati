import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sunti/presentation/controllers/general_controller.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../controllers/splashScreen_controller.dart';

class OrganizingBooks extends StatelessWidget {
  const OrganizingBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final generalCtrl = sl<GeneralController>();
    sl<SplashScreenController>().organizingTime();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.only(top: 64.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              )),
          child: Column(
            children: [
              const Gap(32),
              sunti_iconR(context, width: 100),
              const Gap(32),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Color(0xffE6DAC8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Gap(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'organizingBooks'.tr,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 22,
                          fontFamily: 'naskh',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: generalCtrl.checkFloatingRtlWidget(FAProgressBar(
                        currentValue: 100,
                        size: 5,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        animatedDuration: const Duration(seconds: 5),
                        progressColor: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                      )),
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
