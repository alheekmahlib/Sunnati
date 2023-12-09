import 'package:flutter/material.dart';
import 'package:sunti/core/services/services_locator.dart';
import 'package:sunti/presentation/controllers/general_controller.dart';
import 'package:sunti/presentation/screens/books/data/models/hadith_model.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '/core/utils/constants/extensions.dart';
import 'hadith_inArabic.dart';
import 'hadith_translate.dart';

class ChapterTitle extends StatelessWidget {
  ChapterTitle({super.key});
  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: booksCtrl.getAndSetHadiths(),
        builder: (context, snap) {
          return Column(
            /// عدد ابواب الكتاب
            children: List.generate(
              booksCtrl.currentBookChapters.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                    .convertNumbers('${index + 1}'),
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
                          children: List.generate(
                              booksCtrl.currentBookChapters[index].length, (i) {
                            return Column(
                              children: [
                                HadithInArabic(
                                  arabicHadith:
                                      booksCtrl.currentBookChapters[index][i]
                                          as HadithArabicModel,
                                  secondHadith: booksCtrl
                                      .tempHadithsForSecondLang
                                      .firstWhere((h) =>
                                          h.hadithNumber ==
                                          booksCtrl
                                              .currentBookChapters[index][i]
                                              .hadithNumber),
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
        });
  }
}
