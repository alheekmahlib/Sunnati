import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../core/services/controllers/settings_controller.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/constants/extensions.dart';
import 'language_list.dart';
import 'theme_change.dart';
import 'widgets.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ListView(
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
              Text(
                'appLang'.tr,
                style: TextStyle(
                  fontFamily: sl<SettingsController>().languageFont.value,
                  fontSize: 18,
                  color: ThemeProvider.themeOf(context).id == 'dark'
                      ? Colors.white
                      : Theme.of(context).primaryColorDark,
                ),
              ),
              const LanguageList(),
            ],
          ),
        ),
        Container(
          width: orientation(context, width, 381.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
              color: context.beigeDarkColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Column(
            children: [
              Text(
                'changeTheme'.tr,
                style: TextStyle(
                  fontFamily: sl<SettingsController>().languageFont.value,
                  fontSize: 18,
                  color: ThemeProvider.themeOf(context).id == 'dark'
                      ? Colors.white
                      : Theme.of(context).primaryColorDark,
                ),
              ),
              whiteContainer(context, const ThemeChange(), width: width)
            ],
          ),
        ),
      ],
    );
  }
}
