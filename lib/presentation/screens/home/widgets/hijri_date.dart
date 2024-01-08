import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/beige_container.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/general_controller.dart';

class HijriDate extends StatelessWidget {
  const HijriDate({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    var today = HijriCalendar.now();
    // AppLocalizations.of(context)!.appName == "سُنتي"
    //     ? HijriCalendar.setLocal('ar')
    //     : HijriCalendar.setLocal('en');
    // HijriCalendar.setLocal('ar');
    return BeigeContainer(
      myWidget: Column(
        children: [
          Container(
            // height: 99,
            width: width,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sl<GeneralController>().convertNumbers('${today.hDay}'),
                        style: TextStyle(
                          fontSize: orientation(context, 30.0, 20.0),
                          fontFamily: 'kufi',
                          color: context.textDarkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        sl<GeneralController>().convertNumbers(
                            '${today.hMonth} / ${today.hYear} هـ'),
                        style: TextStyle(
                          fontSize: orientation(context, 20.0, 20.0),
                          fontFamily: 'kufi',
                          color: context.textDarkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/hijri/${today.hMonth}.svg',
                          height: orientation(context, 70.0, 100.0),
                          colorFilter: ColorFilter.mode(
                              context.textDarkColor, BlendMode.srcIn)),
                      Transform.translate(
                        offset: const Offset(-25, -5),
                        child: Text(
                          today.dayWeName.tr,
                          style: TextStyle(
                            fontSize: orientation(context, 22.0, 20.0),
                            fontFamily: 'kufi',
                            color: context.textDarkColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Text(
            '| ${sl<GeneralController>().greeting.value} |',
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'kufi',
              color: context.textDarkColor,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
