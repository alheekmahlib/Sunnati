import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/services/services_locator.dart';
import '../../core/services/shared_pref_services.dart';
import '../../core/utils/constants/lists.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';

class ShareController extends GetxController {
  final ScreenshotController hadithScreenController = ScreenshotController();
  final ScreenshotController translateScreenController = ScreenshotController();
  Uint8List? hadithToImageBytes;
  Uint8List? translateToImageBytes;
  RxString? translateName;
  RxString currentTranslate = 'English'.obs;
  RxString? textTafseer;
  RxBool isTranslate = false.obs;
  RxInt shareTransValue = 0.obs;
  RxString trans = 'en'.obs;

  Future<void> createAndShowHadithImage() async {
    try {
      final Uint8List? imageBytes = await hadithScreenController.capture();
      hadithToImageBytes = imageBytes;
      update();
    } catch (e) {
      debugPrint('Error capturing hadith image: $e');
    }
  }

  Future<void> createAndShowTafseerImage() async {
    try {
      final Uint8List? imageBytes = await translateScreenController.capture();
      translateToImageBytes = imageBytes;
      update();
    } catch (e) {
      debugPrint('Error capturing hadith image: $e');
    }
  }

  bool isRtlLanguage(String languageName) {
    return rtlLang.contains(languageName);
  }

  AlignmentGeometry checkAndApplyRtlLayout(String language) {
    if (isRtlLanguage(language)) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  TextDirection checkApplyRtlLayout(String language) {
    if (isRtlLanguage(language)) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  shareText(String hadithText, hadithName, int hadithNumber) {
    Share.share(
        '﴿$hadithText﴾ '
        '[$hadithName-'
        '$hadithNumber]',
        subject: '$hadithName');
  }

  Future<void> shareHadithWithTranslate() async {
    if (translateToImageBytes! != null) {
      final directory = await getTemporaryDirectory();
      final imagePath =
          await File('${directory.path}/hadith_tafseer_image.png').create();
      await imagePath.writeAsBytes(translateToImageBytes!);
      await Share.shareXFiles([XFile((imagePath.path))], text: 'appName'.tr);
    }
  }

  Future<void> shareVerse(BuildContext context) async {
    if (hadithToImageBytes! != null) {
      final directory = await getTemporaryDirectory();
      final imagePath =
          await File('${directory.path}/hadith_image.png').create();
      await imagePath.writeAsBytes(hadithToImageBytes!);
      await Share.shareXFiles([XFile((imagePath.path))], text: 'appName'.tr);
    }
  }

  shareTranslateHandleRadioValue(int translateVal) async {
    shareTransValue.value = translateVal;
    switch (shareTransValue.value) {
      case 0:
        sl<ShareController>().isTranslate.value = false;
        trans.value = 'nothing';
        await sl<SharedPrefServices>().saveString(TRANS, 'nothing');
      case 1:
        sl<ShareController>().isTranslate.value = true;
        trans.value = 'en';
        await sl<SharedPrefServices>().saveString(TRANS, 'en');
      default:
        trans.value = 'nothing';
    }
  }
}
