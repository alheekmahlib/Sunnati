import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/controllers/bookmark_controller.dart';
import '../../core/services/controllers/general_controller.dart';
import '../../core/services/controllers/settings_controller.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/constants/extensions.dart';
import '../../core/utils/constants/svg_picture.dart';
import '../share/ayah_to_images.dart';
import '../widgets/text_overflow_detector.dart';
import '../widgets/widgets.dart';
import '/features/books/data/models/bookmark_model.dart';

class ReadView extends StatelessWidget {
  final String title;
  final String bookName;
  final String bookNumber;
  final String bookOtherNumber;
  ReadView(
      {super.key,
      required this.title,
      required this.bookName,
      required this.bookNumber,
      required this.bookOtherNumber});

  final ArabicNumbers arabicNumbers = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:
              sunti_icon(context, height: 25, color: context.surfaceDarkColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: arrow_back(context,
                    width: 26, color: context.surfaceDarkColor)),
            onTap: () => Navigator.pop(context),
          ),
          leadingWidth: 58,
          actions: [
            fontSizeDropDown(context),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 32.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'naskh',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: context.surfaceDarkColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        /// عدد ابواب الكتاب
                        children: List.generate(
                          6,
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
                                            arabicNumbers.convert(index + 1),
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
                                            whiteContainer(
                                                context,
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 16.0,
                                                              right: 8.0,
                                                              left: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          hadith_icon(context,
                                                              height: 25),
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                child: share(
                                                                    context,
                                                                    height: 25),
                                                                onTap: () {
                                                                  showHadithOptionsBottomSheet(
                                                                      context,
                                                                      1,
                                                                      2,
                                                                      'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "',
                                                                      'I heard Allahs Messenger (ﷺ) saying, "The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended. So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for." $index',
                                                                      title);
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width: 16.0,
                                                              ),
                                                              GestureDetector(
                                                                child: copy(
                                                                    context,
                                                                    height: 25),
                                                                onTap: () {
                                                                  Clipboard.setData(const ClipboardData(
                                                                          text:
                                                                              'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "'))
                                                                      .then((value) => customSnackBar(
                                                                          context,
                                                                          'copiedHadith'
                                                                              .tr));
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width: 16.0,
                                                              ),
                                                              GestureDetector(
                                                                child: copy(
                                                                    context,
                                                                    height: 25),
                                                                onTap: () {
                                                                  sl<BookmarkController>().box.add(Bookmark(
                                                                      bookName:
                                                                          bookName,
                                                                      bookNumber:
                                                                          bookNumber,
                                                                      bookOtherName:
                                                                          title,
                                                                      chapterTitle:
                                                                          'chapterTitle',
                                                                      hadith:
                                                                          'hadith',
                                                                      hadithNumber:
                                                                          'hadithNumber'));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              right: 8.0,
                                                              left: 8.0),
                                                      child: Obx(
                                                        () => Text(
                                                          'حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ ، قَالَ : حَدَّثَنَا سُفْيَانُ ، قَالَ : حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الْأَنْصَارِيُّ ، قَالَ : أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ ، يَقُولُ : سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ رَضِيَ اللَّهُ عَنْهُ عَلَى الْمِنْبَرِ، قَالَ : سَمِعْتُ رَسُولَ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ، يَقُولُ : " إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "',
                                                          style: TextStyle(
                                                            fontFamily: 'naskh',
                                                            fontSize: sl<
                                                                    GeneralController>()
                                                                .fontSizeArabic
                                                                .value,
                                                            color: context
                                                                .textDarkColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.justify,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            whiteContainer(
                                              context,
                                              ReadMoreLess(
                                                text:
                                                    'I heard Allahs Messenger (ﷺ) saying, "The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended. So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for." $index',
                                                textStyle: TextStyle(
                                                  fontSize:
                                                      sl<GeneralController>()
                                                              .fontSizeArabic
                                                              .value -
                                                          10,
                                                  fontFamily:
                                                      sl<SettingsController>()
                                                          .languageFont
                                                          .value,
                                                  color: context.textDarkColor,
                                                ),
                                                textAlign: TextAlign.center,
                                                readMoreText: 'readMore'.tr,
                                                readLessText: 'readLess'.tr,
                                                buttonTextStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'kufi',
                                                  color: context.textDarkColor,
                                                ),
                                                iconColor:
                                                    context.textDarkColor,
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
