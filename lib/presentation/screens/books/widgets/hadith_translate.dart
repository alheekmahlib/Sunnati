import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/text_overflow_detector.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/settings_controller.dart';
import '../data/models/hadith_model.dart';

class HadithTranslate extends StatelessWidget {
  final HadithBaseModel hadithTranslation;

  const HadithTranslate({super.key, required this.hadithTranslation});

  @override
  Widget build(BuildContext context) {
    return whiteContainer(
      context,
      Obx(() {
        return ReadMoreLess(
          text: hadithTranslation.hadithText,
          textStyle: TextStyle(
            fontSize: sl<GeneralController>().fontSizeArabic.value - 5,
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
        );
      }),
    );
  }
}
