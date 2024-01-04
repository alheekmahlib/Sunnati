import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/services/services_locator.dart';

import '../../../../core/utils/constants/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../../controllers/general_controller.dart';
import 'book_other_name.dart';
import 'hadith_in_arabic.dart';
import 'hadith_translate.dart';

class ChaptersView extends StatelessWidget {
  const ChaptersView({super.key});
  // final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    sl<BooksController>().clearHadithsAndGetNewOnes();
    return GetX<BooksController>(
      builder: (booksCtrl) => booksCtrl.arabicHadiths.isEmpty
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              /// عدد ابواب الكتاب
              controller: booksCtrl.chaptersListViewController.value,
              itemCount: booksCtrl.currentBookChapters.length,
              shrinkWrap:
                  true, // Must be false so the ScorllController can listen..
              primary: false,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  // Column(
                  // mainAxisSize: MainAxisSize.min,
                  // children: [

                  Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(children: [
                  if (index == 0) BookOtherName(),
                  ...[
                    beigeContainer(
                        context,
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
                        customBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    // Column(
                    /// عدد الأحاديث في كل باب
                    // children:
                    ...List.generate(
                        booksCtrl.currentBookChapters[index].length, (i) {
                      return beigeContainer(
                        context,
                        Column(
                          children: [
                            HadithInArabic(
                              arabicHadith: booksCtrl.currentBookChapters[index]
                                  [i],
                              // secondHadith: booksCtrl
                              //     .tempHadithsForSecondLang[i]
                            ),
                            HadithTranslate(
                                currentHadithURN: booksCtrl
                                    .currentBookChapters[index][i].arabicURN),
                          ],
                        ),
                        customBorderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      );
                    }),
                    Obx(() => booksCtrl.loadingMoreBooks.value
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                                child: CircularProgressIndicator.adaptive()),
                          )
                        : const SizedBox.shrink()),
                  ],
                ]),
              ),
            ),
    );
  }
}
