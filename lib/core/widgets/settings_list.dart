import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/controllers/settings_controller.dart';
import '../../presentation/screens/ourApp/ourApps_screen.dart';
import '../services/services_locator.dart';
import '../utils/constants/extensions.dart';
import '../utils/constants/svg_picture.dart';
import 'language_list.dart';
import 'theme_change.dart';
import 'widgets.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          Container(
            width: orientation(context, width, 381.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: context.beigeDarkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Column(
              children: [
                Obx(() {
                  return Text(
                    'appLang'.tr,
                    style: TextStyle(
                      fontFamily: sl<SettingsController>().languageFont.value,
                      fontSize: 18,
                      color: context.surfaceDarkColor,
                    ),
                  );
                }),
                const LanguageList(),
              ],
            ),
          ),
          Container(
            width: orientation(context, width, 381.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: context.beigeDarkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Column(
              children: [
                Obx(() {
                  return Text(
                    'changeTheme'.tr,
                    style: TextStyle(
                      fontFamily: sl<SettingsController>().languageFont.value,
                      fontSize: 18,
                      color: context.surfaceDarkColor,
                    ),
                  );
                }),
                whiteContainer(context, const ThemeChange(), width: width)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: beigeContainer(
                context,
                whiteContainer(
                  context,
                  InkWell(
                    child: SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: alheekmah_logo(context,
                                  width: 60.0,
                                  color: context.surfaceDarkColor)),
                          vDivider(context),
                          Expanded(
                            flex: 6,
                            child: Text(
                              'ourApps'.tr,
                              style: TextStyle(
                                fontFamily: 'kufi',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: context.surfaceDarkColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: context.surfaceDarkColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, animatRoute(const OurApps()));
                    },
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
