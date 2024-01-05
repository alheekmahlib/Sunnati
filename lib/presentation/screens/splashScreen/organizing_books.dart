import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:sunti/core/widgets/widgets.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../controllers/splashScreen_controller.dart';

class OrganizingBooks extends StatelessWidget {
  const OrganizingBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final splashCtrl = sl<SplashScreenController>();
    splashCtrl.organizingTime();
    return SafeArea(
      child: Scaffold(
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
            child: ListView(
              children: [
                const Gap(16),
                sunti_iconR(context, width: 80),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 2.0),
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
                            fontSize: 16,
                            fontFamily: 'kufi',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: PrimerProgressBar(
                          segments: splashCtrl.segments,
                          legendStyle: const SegmentedBarLegendStyle(
                            maxLines: 9,
                          ),
                          legendEllipsisBuilder: (truncatedItemCount) {
                            final value = splashCtrl.segments
                                .skip(splashCtrl.segments.length -
                                    truncatedItemCount)
                                .fold(
                                    0,
                                    (accValue, segment) =>
                                        accValue + segment.value);
                            print('value $value');
                            return LegendItem(
                              segment: Segment(
                                value: value,
                                color: Colors.grey,
                                label: Text(
                                  "Other",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                valueLabel: Text("$value%"),
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(16),
                      whiteContainer(
                          context,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: sunti_iconR(context, width: 20)),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    "تنويه: هذه العملية تظهر مرة واحدة عند تثبيت التطبيق.",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 12,
                                        fontFamily: 'kufi'),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
