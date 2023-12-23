import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/text_overflow_detector.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/settings_controller.dart';

class HadithTranslate extends StatelessWidget {
  final int currentHadithURN;
  const HadithTranslate({super.key, required this.currentHadithURN});

  @override
  Widget build(BuildContext context) {
    return whiteContainer(
      context,
      ReadMoreLess(
        text: sl<BooksController>().getHadithTranslationByURN(currentHadithURN),
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
