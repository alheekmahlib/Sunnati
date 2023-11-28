import 'package:flutter/material.dart';
import 'package:sunti/core/services/services_locator.dart';
import 'package:sunti/presentation/controllers/general_controller.dart';

import '/core/utils/constants/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import 'hadith_inArabic.dart';
import 'hadith_translate.dart';

class ChapterTitle extends StatelessWidget {
  final String title;
  final String bookName;
  final String bookNumber;
  const ChapterTitle(
      {super.key,
      required this.title,
      required this.bookName,
      required this.bookNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      /// عدد ابواب الكتاب
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: beigeContainer(
              context,
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          sl<GeneralController>()
                              .arabicNumbers
                              .convert(index + 1),
                          style: TextStyle(
                            fontFamily: 'naskh',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: context.textDarkColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: whiteContainer(
                          context,
                          Text(
                            'باب',
                            style: TextStyle(
                              fontFamily: 'naskh',
                              fontSize: 24,
                              color: context.textDarkColor,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    /// عدد الأحاديث في كل باب
                    children: List.generate(2, (index) {
                      return Column(
                        children: [
                          HadithInArabic(
                            title: title,
                            bookName: bookName,
                            bookNumber: bookNumber,
                          ),
                          const HadithTranslate(),
                        ],
                      );
                    }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
