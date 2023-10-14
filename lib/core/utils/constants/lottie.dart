import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget search_loading({double? width, double? height}) {
  return Lottie.asset('assets/lottie/search_loading.json',
      width: width, height: height);
}

Widget shareLottie({double? width, double? height}) {
  return Lottie.asset('assets/lottie/share.json', width: width, height: height);
}

Widget loading({double? width, double? height}) {
  return Lottie.asset('assets/lottie/splash_loading.json',
      width: width, height: height);
}
