import 'dart:io';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../core/services/controllers/general_controller.dart';
import '../../core/services/services_locator.dart';
import '../../core/services/shared_pref_services.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../../core/utils/constants/svg_picture.dart';
import '/core/utils/constants/extensions.dart';

orientation(BuildContext context, var n1, n2) {
  Orientation orientation = MediaQuery.orientationOf(context);
  return orientation == Orientation.portrait ? n1 : n2;
}

platformView(var p1, p2) {
  return (Platform.isIOS || Platform.isAndroid || Platform.isFuchsia) ? p1 : p2;
}

screenModalBottomSheet(BuildContext context, Widget child) {
  double hei = MediaQuery.sizeOf(context).height;
  double wid = MediaQuery.sizeOf(context).width;
  showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          maxWidth: platformView(
              orientation(context, wid, wid * .7), wid / 1 / 2 * 1.5),
          maxHeight:
              orientation(context, hei * .9, platformView(hei, hei * 3 / 4))),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      });
}

optionsModalBottomSheet(BuildContext context, Widget child, {double? height}) {
  double hei = MediaQuery.sizeOf(context).height;
  double wid = MediaQuery.sizeOf(context).width;
  showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          maxWidth: platformView(orientation(context, wid, wid * .5), wid * .5),
          maxHeight: height ??
              orientation(context, hei * .5, platformView(hei, hei * .5))),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      });
}

Widget hijriDate(BuildContext context) {
  ArabicNumbers arabicNumber = ArabicNumbers();
  var today = HijriCalendar.now();
  // AppLocalizations.of(context)!.appName == "سُنتي"
  //     ? HijriCalendar.setLocal('ar')
  //     : HijriCalendar.setLocal('en');
  HijriCalendar.setLocal('ar');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              arabicNumber.convert('${today.hDay}'),
              style: TextStyle(
                fontSize: orientation(context, 30.0, 20.0),
                fontFamily: 'kufi',
                color: context.textDarkColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              arabicNumber.convert('${today.hMonth} / ${today.hYear} هـ'),
              style: TextStyle(
                fontSize: orientation(context, 20.0, 20.0),
                fontFamily: 'kufi',
                color: context.textDarkColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/hijri/${today.hMonth}.svg',
                height: orientation(context, 70.0, 100.0),
                colorFilter:
                    ColorFilter.mode(context.textDarkColor, BlendMode.srcIn)),
            Transform.translate(
              offset: const Offset(-25, -5),
              child: Text(
                arabicNumber.convert(today.dayWeName),
                style: TextStyle(
                  fontSize: orientation(context, 22.0, 20.0),
                  fontFamily: 'kufi',
                  color: context.textDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget greeting(BuildContext context) {
  return Text(
    '| ${sl<GeneralController>().greeting.value} |',
    style: TextStyle(
      fontSize: 16.0,
      fontFamily: 'kufi',
      color: context.textDarkColor,
    ),
    textAlign: TextAlign.center,
  );
}

Route animatRoute(Widget myWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => myWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget beigeContainer(BuildContext context, Widget myWidget,
    {double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
    decoration: BoxDecoration(
        color: context.beigeDarkColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        )),
    child: myWidget,
  );
}

Widget whiteContainer(BuildContext context, Widget myWidget,
    {double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        )),
    child: myWidget,
  );
}

Widget fontSizeDropDown(BuildContext context) {
  return PopupMenuButton(
    position: PopupMenuPosition.under,
    icon: Semantics(
      button: true,
      enabled: true,
      label: 'Change Font Size',
      child: Icon(
        Icons.format_size_rounded,
        size: 28,
        color: context.surfaceDarkColor,
      ),
    ),
    color: Theme.of(context).colorScheme.surface.withOpacity(.8),
    itemBuilder: (context) => [
      PopupMenuItem(
        height: 30,
        child: Obx(
          () => SizedBox(
            height: 30,
            width: MediaQuery.sizeOf(context).width,
            child: FlutterSlider(
              values: [sl<GeneralController>().fontSizeArabic.value],
              max: 50,
              min: 24,
              rtl: true,
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: 5,
                activeTrackBarHeight: 5,
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.background),
              ),
              handlerAnimation: const FlutterSliderHandlerAnimation(
                  curve: Curves.elasticOut,
                  reverseCurve: null,
                  duration: Duration(milliseconds: 700),
                  scale: 1.4),
              onDragging: (handlerIndex, lowerValue, upperValue) async {
                lowerValue = lowerValue;
                upperValue = upperValue;
                sl<GeneralController>().fontSizeArabic.value = lowerValue;
                await sl<SharedPrefServices>()
                    .saveDouble(FONT_SIZE, lowerValue);
              },
              handler: FlutterSliderHandler(
                decoration: const BoxDecoration(),
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.transparent,
                  elevation: 3,
                  child: SvgPicture.asset('assets/svg/hadith_icon.svg'),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget customDivider(BuildContext context, {double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: context.textDarkColor,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
  );
}

customSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 3000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: context.surfaceDarkColor,
    content: SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: hadith_icon(context, height: 30.0),
          ),
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'kufi',
                  fontStyle: FontStyle.italic,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: hadith_icon(context, height: 30.0),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
