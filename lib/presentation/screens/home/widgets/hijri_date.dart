import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';

class HijriDate extends StatelessWidget {
  const HijriDate({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return beigeContainer(
      context,
      Column(
        children: [
          Container(
            // height: 99,
            width: width,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: hijriDate(context),
          ),
          greeting(context)
        ],
      ),
    );
  }
}
