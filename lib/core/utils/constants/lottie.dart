import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget search_loading({double? width, double? height}) {
  return Lottie.asset('assets/lottie/search_loading.json',
      width: width, height: height);
}

Widget shareLottie({double? width, double? height}) {
  return Lottie.asset('assets/lottie/shareLottie.json',
      width: width, height: height);
}

Widget loading({double? width, double? height}) {
  return Lottie.asset('assets/lottie/splash_loading.json',
      width: width, height: height);
}

Widget bookmarkLottie({double? width, double? height}) {
  return Lottie.asset('assets/lottie/bookmark.json',
      width: width, height: height);
}
