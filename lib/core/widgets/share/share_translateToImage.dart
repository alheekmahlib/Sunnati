import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunti/core/widgets/widgets.dart';

import '../../../presentation/controllers/share_controller.dart';
import '../../services/services_locator.dart';
import '../../utils/constants/svg_picture.dart';

class TranslateImageCreator extends StatelessWidget {
  final String bookName;
  final String bookOtherNumber;
  final String chapterName;
  final int hadithNumber;
  final int bookNumber;
  final String hadithText;
  final String hadithTranslate;

  const TranslateImageCreator({
    Key? key,
    required this.bookName,
    required this.bookOtherNumber,
    required this.chapterName,
    required this.hadithNumber,
    required this.bookNumber,
    required this.hadithText,
    required this.hadithTranslate,
  }) : super(key: key);

  Widget buildVerseImageWidget({
    required BuildContext context,
    required String bookName,
    required int hadithNumber,
    required int bookNumber,
    required String hadithText,
    required String translateText,
  }) {
    final translateToImage = sl<ShareController>();
    final ArabicNumbers arabicNumbers = ArabicNumbers();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 1280.0,
        decoration: const BoxDecoration(
            color: Color(0xff3C2A21),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              color: Color(0xffF7F1EC),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Color(0xffE6DAC8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    )),
                child: Column(
                  children: [
                    whiteContainer(
                      context,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            book_name(
                                context, '$bookNumber', const Color(0xff3C2A21),
                                height: 50),
                            vDivider(context, height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookOtherNumber,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'naskh',
                                    color: Color(0xff3C2A21),
                                  ),
                                ),
                                const Gap(4),
                                beigeContainer(
                                  context,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      chapterName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'naskh',
                                        color: Color(0xff3C2A21),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      bookName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'naskh',
                        color: Color(0xff3C2A21),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              frame(context, height: 40.0),
              const Gap(16),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: hadith_icon(context, height: 20),
                          ),
                          TextSpan(
                            text: ' $hadithText\n\n',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'naskh',
                              color: Color(0xff3C2A21),
                            ),
                          ),
                          WidgetSpan(
                              child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 2,
                              color: const Color(0xffE6DAC8),
                            )),
                            child: Text(
                              'رقم الحديث: ${arabicNumbers.convert(hadithNumber)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'naskh',
                                color: Color(0xff3C2A21),
                              ),
                            ),
                          ))
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Gap(16),
                  Obx(
                    () => translateToImage.isTranslate.value
                        ? Align(
                            alignment: translateToImage.checkAndApplyRtlLayout(
                                translateToImage.currentTranslate.value),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: const BoxDecoration(
                                  color: Color(0xffE6DAC8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Obx(
                                () => Text(
                                  translateToImage.currentTranslate.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'kufi',
                                    color: Color(0xff3C2A21),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Gap(8),
                  Obx(
                    () => translateToImage.isTranslate.value
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                                color: const Color(0xffE6DAC8).withOpacity(.7),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: hadith_icon(context, height: 20),
                                  ),
                                  TextSpan(
                                    text: ' $translateText\n\n',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'naskh',
                                      color: Color(0xff3C2A21),
                                    ),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 2,
                                      color: const Color(0xffE6DAC8),
                                    )),
                                    child: Text(
                                      'Hadith Number: $hadithNumber',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'naskh',
                                        color: Color(0xff3C2A21),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
              Obx(
                () => translateToImage.isTranslate.value
                    ? const Gap(24)
                    : const Gap(0),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  frame(context, height: 40.0),
                  Container(
                    color: const Color(0xffF7F1EC),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'سُنتــي',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'kufi',
                                color: Color(0xff3C2A21),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'SUNTI',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'kufi',
                                color: Color(0xff3C2A21),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const Gap(8),
                        sunti_logo(context, height: 38.0),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translateToImage = sl<ShareController>();

    return Column(
      children: [
        Screenshot(
          controller: translateToImage.translateScreenController,
          child: buildVerseImageWidget(
            context: context,
            bookName: bookName,
            hadithNumber: hadithNumber,
            bookNumber: bookNumber,
            hadithText: hadithText,
            translateText: hadithTranslate,
          ),
        ),
        // if (ayahToImage.ayahToImageBytes != null)
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Image.memory(ayahToImage.ayahToImageBytes!),
        //   ),
      ],
    );
  }
}
