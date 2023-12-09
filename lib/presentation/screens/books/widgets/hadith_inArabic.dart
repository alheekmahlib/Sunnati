import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/share/hadith_to_images.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/bookmark_controller.dart';
import '../../../controllers/general_controller.dart';
import '../data/models/bookmark_model.dart';
import '../data/models/hadith_model.dart';

class HadithInArabic extends StatelessWidget {
  final HadithArabicModel arabicHadith;
  final HadithBaseModel secondHadith;
  const HadithInArabic(
      {super.key, required this.arabicHadith, required this.secondHadith});

  @override
  Widget build(BuildContext context) {
    return whiteContainer(
        context,
        Column(
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
                            secondHadith.hadithText,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      GestureDetector(
                        child: copy(context, height: 25),
                        onTap: () {
                          Clipboard.setData(const ClipboardData(
                                  text:
                                      'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "'))
                              .then((value) =>
                                  customSnackBar(context, 'copiedHadith'.tr));
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
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
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
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
