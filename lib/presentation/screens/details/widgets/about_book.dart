import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/widgets/widgets.dart';

class AboutBook extends StatelessWidget {
  final String bookDetails;
  const AboutBook({super.key, required this.bookDetails});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return beigeContainer(
      context,
      ExpansionTileCard(
        elevation: 0.0,
        initialElevation: 0.0,
        expandedTextColor: context.textDarkColor,
        title: SizedBox(
          width: 100.0,
          child: Text(
            'aboutBook'.tr,
            style: TextStyle(
              fontFamily: 'kufi',
              fontSize: 16,
              color: ThemeProvider.themeOf(context).id == 'dark'
                  ? Colors.white
                  : Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        baseColor: Theme.of(context).colorScheme.background,
        expandedColor: Theme.of(context).colorScheme.background,
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              buttonHeight: 42.0,
              buttonMinWidth: 90.0,
              children: [
                Text(
                  bookDetails,
                  style: TextStyle(
                    fontFamily: 'naskh',
                    fontSize: 20,
                    color: ThemeProvider.themeOf(context).id == 'dark'
                        ? Colors.white
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
              ]),
        ],
      ),
      width: orientation(context, width, 381.0),
    );
  }
}
