import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/extensions.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../controllers/bookmark_controller.dart';
import 'widget/bookmark_card.dart';

class BookmarksScreen extends StatelessWidget {
  BookmarksScreen({super.key});

  final ArabicNumbers arabicNumbers = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          controller: sl<BookmarkController>().scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Obx(
                      () {
                        if (sl<BookmarkController>().bookmark.isEmpty) {
                          return Center(
                            child: bookmarkLottie(height: 150.0),
                          );
                        }
                        return const BookmarkCard();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.translate(
                    offset: const Offset(19, -20),
                    child: bookmark_logo(context, height: 130),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: const Offset(0, 55),
                    child: Text(
                      'bookmark'.tr,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'kufi',
                        fontWeight: FontWeight.w600,
                        color: context.surfaceDarkColor,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
