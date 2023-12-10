import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/share/hadith_to_images.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/bookmark_controller.dart';
import '../../../controllers/general_controller.dart';
import '../data/models/bookmark_model.dart';

class HadithInArabic extends StatelessWidget {
  final String bookName;
  final String arAndEnName;
  final String bookOtherName;
  final String chapterName;
  final int bookNumber;
  final int hadithNumber;
  const HadithInArabic(
      {super.key,
      required this.bookName,
      required this.arAndEnName,
      required this.bookOtherName,
      required this.chapterName,
      required this.bookNumber,
      required this.hadithNumber});

  @override
  Widget build(BuildContext context) {
    final general = sl<GeneralController>();
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
                            bookName,
                            bookOtherName,
                            chapterName,
                            1,
                            bookNumber,
                            'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "',
                            'I heard Allahs Messenger (ﷺ) saying, "The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended. So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for."',
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
                                    text: general.copyHadith(
                                        bookName,
                                        bookOtherName,
                                        chapterName,
                                        hadithNumber)))
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
                                    text: general.copyHadithWithTranslate(
                                        arAndEnName,
                                        bookOtherName,
                                        chapterName,
                                        hadithNumber)))
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
                              bookName: bookName,
                              bookNumber: '$bookNumber',
                              bookOtherName: bookOtherName,
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
                  'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "',
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
