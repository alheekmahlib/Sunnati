import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_stepper_step/horizontal_stepper_step.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:sunti/presentation/controllers/onboarding_controller.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/lists.dart';
import '../../../../core/widgets/beige_container.dart';
import '../../../../core/widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final onboarding = sl<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: MediaQuery.sizeOf(context).height * .8,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Obx(
                      () => HorizontalStepper(
                        totalStep: 4,
                        completedStep: onboarding.pageNumber.value,
                        selectedColor: context.surfaceDarkColor,
                        backGroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'تخطي',
                          style: TextStyle(
                            color: context.surfaceDarkColor.withOpacity(.4),
                            fontSize: 16.0,
                            fontFamily: 'kufi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Obx(
                        () => onboarding.pageNumber.value == 4
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0),
                                  onPressed: () {
                                    if (onboarding.pageNumber.value == 4) {
                                      Navigator.pop(context);
                                    } else {
                                      onboarding.controller.animateToPage(
                                          onboarding.controller.page!.toInt() +
                                              1,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                  child: Text('أبدأ',
                                      style: TextStyle(
                                          fontFamily: 'kufi',
                                          fontSize: 18,
                                          color: context.surfaceDarkColor)),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0),
                                  onPressed: () {
                                    onboarding.controller.animateToPage(
                                        onboarding.controller.page!.toInt() + 1,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: context.surfaceDarkColor,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: orientation(
                      context,
                      const EdgeInsets.only(
                        top: 60.0,
                      ),
                      const EdgeInsets.only(
                        top: 60.0,
                      )),
                  child: PageView.builder(
                      controller: onboarding.controller,
                      itemCount: platformView(
                          orientation(context, images.length, images.length),
                          images.length),
                      onPageChanged: (page) {
                        onboarding.pageNumber.value = page + 1;
                        onboarding.indicator(page);
                      },
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Wrap(
                            children: [
                              Center(
                                child: BeigeContainer(
                                  myWidget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      platformView(
                                          orientation(context, images[index],
                                              imagesL[index]),
                                          imagesD[index]),
                                    ),
                                  ),
                                  width: platformView(
                                      MediaQuery.sizeOf(context).width / 1 / 2,
                                      MediaQuery.sizeOf(context).width /
                                          1 /
                                          2 *
                                          .8),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: context.surfaceDarkColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ))),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Text(
                                        onboardingTitle[index],
                                        style: TextStyle(
                                            color: context.surfaceDarkColor,
                                            fontSize: 18,
                                            height: 2,
                                            fontFamily: 'kufi'),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
