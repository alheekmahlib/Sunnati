import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/lists.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/main/main_screen.dart';
import '../screens/splashScreen/organizing_books.dart';

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
    // TODO: make this null if you wanna organizing screen start first time only
    if (sl<SharedPreferences>().getBool(IS_FIRST_TIME_ORG) == null) {
      Get.off(() => const OrganizingBooks(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut);
    } else {
      await organizingTime();
      sl<SharedPreferences>().setBool(IS_FIRST_TIME_ORG, false);
    }
  }

  Future organizingTime() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.off(() => const MainScreen(),
        transition: Transition.downToUp,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut);
    sl<SharedPreferences>().setBool(IS_FIRST_TIME_ORG, false);
  }

  final segments = [
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[0]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[1]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[2]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[3]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[4]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[5]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[6]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[7]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[8]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[9]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[10]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[11]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[12]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[13]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
    Segment(
        value: 6,
        color: const Color(0xff604536),
        label: Text(
          booksList[14]['name'],
          style: const TextStyle(
              color: Color(0xff604536), fontFamily: 'kufi', fontSize: 12),
        )),
  ];
}
