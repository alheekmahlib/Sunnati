import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/text_overflow_detector.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/settings_controller.dart';

class HadithTranslate extends StatelessWidget {
  const HadithTranslate({super.key});

  @override
  Widget build(BuildContext context) {
    return whiteContainer(
      context,
      ReadMoreLess(
        text:
            'I heard Allahs Messenger (ﷺ) saying, "The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended. So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for."',
        textStyle: TextStyle(
          fontSize: sl<GeneralController>().fontSizeArabic.value - 10,
          fontFamily: sl<SettingsController>().languageFont.value,
          color: context.textDarkColor,
        ),
        textAlign: TextAlign.justify,
        readMoreText: 'readMore'.tr,
        readLessText: 'readLess'.tr,
        buttonTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'kufi',
          color: context.textDarkColor,
        ),
        iconColor: context.textDarkColor,
      ),
    );
  }
}
