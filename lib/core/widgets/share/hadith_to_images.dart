import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:sunti/presentation/controllers/share_controller.dart';

import '../../services/services_locator.dart';
import '../../utils/constants/lottie.dart';
import '../../utils/constants/svg_picture.dart';
import '../widgets.dart';
import 'share_translateToImage.dart';

Future<void> showHadithOptionsBottomSheet(
  BuildContext context,
  String bookName,
  String bookOtherNumber,
  String chapterName,
  int hadithNumber,
  int bookNumber,
  String hadithText,
  String hadithTranslate,
) async {
  final hadithShare = sl<ShareController>();
  List<String> translateName = <String>[
    'Nothing',
    'English',
  ];
  Get.bottomSheet(
    isScrollControlled: true,
    SizedBox(
      height: MediaQuery.sizeOf(context).height * .9,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, 1),
                child: button_curve(context),
              ),
              GestureDetector(
                child: close(context, height: 30.0),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  )),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: shareLottie(height: 60.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: ListView(
                      children: [
                        GestureDetector(
                          child: beigeContainer(
                            context,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    'shareText'.tr,
                                    style: TextStyle(
                                        color: context.surfaceDarkColor,
                                        fontSize: 16,
                                        fontFamily: 'kufi'),
                                  ),
                                ),
                                whiteContainer(
                                    context,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Icon(
                                              Icons.text_fields,
                                              color: context.surfaceDarkColor,
                                              size: 24,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                              hadithText,
                                              style: TextStyle(
                                                  color:
                                                      context.surfaceDarkColor,
                                                  fontSize: 16,
                                                  fontFamily: 'naskh'),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    width: MediaQuery.sizeOf(context).width),
                              ],
                            ),
                          ),
                          onTap: () {
                            hadithShare.shareText(
                                hadithText, bookName, hadithNumber);
                            Navigator.pop(context);
                          },
                        ),
                        const Gap(4),
                        hDivider(context,
                            width: MediaQuery.sizeOf(context).width),
                        const Gap(4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                child: beigeContainer(
                                  context,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'shareImage'.tr,
                                              style: TextStyle(
                                                  color:
                                                      context.surfaceDarkColor,
                                                  fontSize: 16,
                                                  fontFamily: 'kufi'),
                                            ),
                                            PopupMenuButton(
                                              position: PopupMenuPosition.under,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              child: whiteContainer(
                                                context,
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Obx(
                                                        () => Text(
                                                          hadithShare
                                                              .currentTranslate
                                                              .value,
                                                          style: TextStyle(
                                                            fontFamily: 'kufi',
                                                            fontSize: 16,
                                                            color: context
                                                                .surfaceDarkColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        size: 20,
                                                        color: context
                                                            .surfaceDarkColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              itemBuilder: (context) =>
                                                  translateName.map(
                                                (e) {
                                                  int selectedIndex = 0;
                                                  translateName
                                                      .asMap()
                                                      .forEach((index, item) {
                                                    if (item == e) {
                                                      selectedIndex = index;
                                                    }
                                                  });
                                                  return PopupMenuItem<Widget>(
                                                    value: Text(
                                                      e,
                                                    ),
                                                    child: Obx(
                                                      () => GestureDetector(
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                            fontFamily: 'kufi',
                                                            fontSize: 18,
                                                            color: hadithShare
                                                                        .shareTransValue
                                                                        .value ==
                                                                    selectedIndex
                                                                ? context
                                                                    .surfaceDarkColor
                                                                : context
                                                                    .surfaceDarkColor
                                                                    .withOpacity(
                                                                        .4),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          hadithShare
                                                                  .currentTranslate
                                                                  .value =
                                                              translateName[
                                                                  selectedIndex];
                                                          hadithShare
                                                              .shareTranslateHandleRadioValue(
                                                                  selectedIndex);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TranslateImageCreator(
                                        bookName: bookName,
                                        bookOtherNumber: bookOtherNumber,
                                        chapterName: chapterName,
                                        hadithNumber: hadithNumber,
                                        bookNumber: bookNumber,
                                        hadithText: hadithText,
                                        hadithTranslate: hadithTranslate,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  await hadithShare.createAndShowTafseerImage();
                                  hadithShare.shareHadithWithTranslate();
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
