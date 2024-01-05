import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/main/main_screen.dart';
import '../screens/splashScreen/organizing_books.dart';
import 'books_controller.dart';

class SplashScreenController extends GetxController {
  RxBool animate = false.obs;
  late final maxTotalValue = segments.fold(2, (acc, seg) => acc + seg.value);

  late int displaySegmentCount = segments.length ~/ 2;
  late double sliderValue = segments.length / 2;
  bool alwaysFillBar = false;
  bool limitLegendLines = false;

  Future startTime() async {
    await Future.delayed(const Duration(seconds: 1));
    animate.value = true;
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const OrganizingBooks(),
        transition: Transition.downToUp,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut);
  }

  Future organizingTime() async {
    // TODO: do this null if you wanna organizing screen start first time only
    if (sl<SharedPreferences>().getBool(IS_FIRST_TIME_ORG) == false) {
      await Future.delayed(const Duration(seconds: 5));
      Get.off(() => const MainScreen(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut);
      sl<SharedPreferences>().setBool(IS_FIRST_TIME_ORG, false);
    }
  }

  final segments = [
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[0].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[1].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[2].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[3].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[4].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[5].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[6].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[7].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[8].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[9].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[10].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[11].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[12].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[13].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          sl<BooksController>().allCollections[14].bookName,
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
  ];
}
