import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../presentation/controllers/general_controller.dart';
import '../services/services_locator.dart';
import '../services/shared_pref_services.dart';
import '../utils/constants/shared_preferences_constants.dart';

class FontSizeDropDown extends StatelessWidget {
  const FontSizeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
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
}
