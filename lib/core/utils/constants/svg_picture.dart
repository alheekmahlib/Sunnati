import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/core/utils/constants/extensions.dart';

home(BuildContext context) {
  return SvgPicture.asset(
    'assets/svg/home.svg',
    width: 24.h,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

bookmark(BuildContext context) {
  return SvgPicture.asset(
    'assets/svg/bookmark.svg',
    width: 24.h,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

bookmark2(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/bookmark2.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.surfaceDarkColor, BlendMode.srcIn),
  );
}

books(BuildContext context) {
  return SvgPicture.asset(
    'assets/svg/books.svg',
    width: 24.h,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

logo_stroke(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/logo_stroke.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

search(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/search.svg',
    height: height,
    width: width ?? 22.h,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

sunti_iconR(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/sunti_iconR.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.surface, BlendMode.srcIn),
  );
}

sunti_icon(BuildContext context,
    {double? height, double? width, Color? color}) {
  return SvgPicture.asset(
    'assets/svg/sunti_icon.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
  );
}

book_name(BuildContext context, String name, Color color,
    {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/book_name/$name.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}

open_book(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/lastRead.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.textDarkColor, BlendMode.srcIn),
  );
}

book_cover(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/book.svg',
    height: height,
    width: width,
  );
}

arrow_back(BuildContext context,
    {double? height, double? width, Color? color}) {
  return SvgPicture.asset(
    'assets/svg/arrow.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
  );
}

button_curve(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/buttonCurve.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.background, BlendMode.srcIn),
  );
}

close(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/close.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.surfaceDarkColor, BlendMode.srcIn),
  );
}

hours(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/24-hours.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.textDarkColor, BlendMode.srcIn),
  );
}

hadith_icon(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/hadith_icon.svg',
    height: height,
    width: width,
  );
}

copy(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/copy.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.surfaceDarkColor, BlendMode.srcIn),
  );
}

share(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/share.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.surfaceDarkColor, BlendMode.srcIn),
  );
}

bookmark_logo(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/bookmark_logo.svg',
    height: height,
    width: width,
  );
}

setting_lines(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/setting_lines.svg',
    height: height,
    width: width,
  );
}

sunti_logo(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/sunti_logo.svg',
    height: height,
    width: width,
  );
}

alheekmah_logo(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/alheekmah_logo.svg',
    height: height,
    width: width,
    colorFilter: const ColorFilter.mode(Color(0xff3C2A21), BlendMode.srcIn),
  );
}
