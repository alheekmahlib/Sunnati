import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

import '../../../features/home/data/models/time_now.dart';

class GeneralController extends GetxController {
  RxInt selected = 0.obs;
  RxString greeting = ''.obs;
  TimeNow timeNow = TimeNow();
  RxBool isExpanded = false.obs;
  RxDouble fontSizeArabic = 24.0.obs;
  PageController controller = PageController();
  GlobalKey<SliderDrawerState> key = GlobalKey<SliderDrawerState>();
  final ArabicNumbers arabicNumbers = ArabicNumbers();

  /// Greeting
  updateGreeting() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    greeting.value = isMorning ? 'صبحكم الله بالخير' : 'مساكم الله بالخير';
  }
}
