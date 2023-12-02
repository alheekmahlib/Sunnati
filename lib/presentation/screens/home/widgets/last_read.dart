import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/extensions.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';

class LastRead extends StatelessWidget {
  const LastRead({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: beigeContainer(
        context,
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '| ${'lastRead'.tr} |',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'kufi',
                  fontWeight: FontWeight.w500,
                  color: context.textDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    width: width,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        )),
                    child: Text(
                      '" إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا، فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ "',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'naskh',
                          fontWeight: FontWeight.w500,
                          color: context.textDarkColor,
                          height: 1.5),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: book_name(context, '1', context.textDarkColor,
                        height: 60)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    'كتاب بدء الوحي',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.w600,
                      color: context.textDarkColor,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset: const Offset(0, -5),
                      child: open_book(context, height: 25),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
