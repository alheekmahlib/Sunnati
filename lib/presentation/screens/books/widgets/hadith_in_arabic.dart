import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/share/hadith_to_images.dart';
import '../../../../core/widgets/white_container.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/bookmark_controller.dart';
import '../../../controllers/books_controller.dart';
import '../../../controllers/general_controller.dart';
import '../data/models/ar_hadith_model.dart';
import '../data/models/bookmark_model.dart';

class HadithInArabic extends StatelessWidget {
  final ARHadithModel arabicHadith;
  // final ENHadithModel secondHadith;
  HadithInArabic({super.key, required this.arabicHadith});

  final generalCtrl = sl<GeneralController>();
  final booksCtrl = sl<BooksController>();

  @override
  Widget build(BuildContext context) {
    return WhiteContainer(
        myWidget: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              hadith_icon(context, height: 25),
              Row(
                children: [
                  GestureDetector(
                    child: share(context, height: 25),
                    onTap: () {
                      showHadithOptionsBottomSheet(
                        context,
                        arabicHadith.bookName ?? 'no book name',
                        'bookOtherNumber',
                        arabicHadith.babName ?? 'no chapter title',
                        1,
                        arabicHadith.bookNumber,
                        arabicHadith.hadithText,
                        booksCtrl
                            .getHadithTranslationByURN(arabicHadith.arabicURN),
                      );
                    },
                  ),
                  const Gap(
                    16,
                  ),
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    color: Theme.of(context).colorScheme.background,
                    child: copy(context, height: 25),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<Widget>(
                        child: Text(
                          'hadith'.tr,
                          style: TextStyle(
                              fontFamily: 'kufi',
                              fontSize: 18,
                              color: context.surfaceDarkColor),
                        ),
                        onTap: () => Clipboard.setData(ClipboardData(
                                text: generalCtrl.copyHadith(
                                    arabicHadith.bookName,
                                    arabicHadith.bookName,
                                    arabicHadith.bookName,
                                    arabicHadith.hadithNumber)))
                            .then((value) =>
                                customSnackBar(context, 'copiedHadith'.tr)),
                      ),
                      PopupMenuItem<Widget>(
                        child: Text(
                          'hadithWithTranslate'.tr,
                          style: TextStyle(
                              fontFamily: 'kufi',
                              fontSize: 18,
                              color: context.surfaceDarkColor),
                        ),
                        onTap: () => Clipboard.setData(ClipboardData(
                                text: generalCtrl.copyHadithWithTranslate(
                                    arabicHadith.bookName,
                                    arabicHadith.bookName,
                                    arabicHadith.babName ?? '',
                                    arabicHadith.hadithNumber)))
                            .then((value) =>
                                customSnackBar(context, 'copiedHadith'.tr)),
                      ),
                    ],
                  ),
                  const Gap(
                    16,
                  ),
                  GestureDetector(
                    child: bookmark2(context, height: 25),
                    onTap: () {
                      sl<BookmarkController>().box.add(Bookmark(
                          bookName: arabicHadith.bookName ?? 'no book name',
                          bookNumber: arabicHadith.bookNumber.toString(),
                          bookOtherName: 'bookOtherNumber',
                          chapterTitle: 'chapterTitle',
                          hadith: 'hadith',
                          hadithNumber: 'hadithNumber'));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
          child: Obx(
            () => Text(
              arabicHadith.hadithText,
              style: TextStyle(
                fontFamily: 'naskh',
                fontSize: sl<GeneralController>().fontSizeArabic.value,
                color: context.textDarkColor,
              ),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    ));
  }
}
