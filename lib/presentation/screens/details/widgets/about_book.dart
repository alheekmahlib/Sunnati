import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/beige_container.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';

class AboutBook extends StatelessWidget {
  AboutBook({super.key});
  final bookDetails = sl<BooksController>().currentCollection.currentBookAbout;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return BeigeContainer(
      myWidget: ExpansionTileCard(
        elevation: 0.0,
        initialElevation: 0.0,
        expandedTextColor: context.surfaceDarkColor,
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
                  textAlign: TextAlign.justify,
                ),
              ]),
        ],
      ),
      width: orientation(context, width, 381.0),
    );
  }
}
