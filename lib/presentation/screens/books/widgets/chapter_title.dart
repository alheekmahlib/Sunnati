import 'package:flutter/material.dart';
import 'package:sunti/core/services/services_locator.dart';

import '../../../../core/utils/constants/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../../controllers/general_controller.dart';
import 'hadith_in_arabic.dart';

class ChapterTitle extends StatelessWidget {
  ChapterTitle({super.key});
  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: booksCtrl.getAndSetHadiths(),
        builder: (context, snap) {
          return snap.connectionState != ConnectionState.done && !snap.hasData
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Column(
                  /// عدد ابواب الكتاب
                  children: List.generate(
                    booksCtrl.currentBookChapters.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
                                        booksCtrl.currentBookChapters[index][0]
                                                .babName ??
                                            'باب', // 'باب',
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
                                    booksCtrl.currentBookChapters[index].length,
                                    (i) {
                                  return Column(
                                    children: [
                                      HadithInArabic(
                                        arabicHadith: booksCtrl
                                            .currentBookChapters[index][i],
                                        // secondHadith: booksCtrl
                                        //     .tempHadithsForSecondLang[i]
                                      ),
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
