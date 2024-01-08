import 'package:flutter/material.dart';

import '/core/utils/constants/extensions.dart';

class BeigeContainer extends StatelessWidget {
  final Widget myWidget;
  final double? height;
  final double? width;
  final BorderRadius? customBorderRadius;
  const BeigeContainer(
      {super.key,
      required this.myWidget,
      this.height,
      this.width,
      this.customBorderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: context.beigeDarkColor,
        borderRadius: customBorderRadius ??
            const BorderRadius.all(
              Radius.circular(8.0),
            ),
      ),
      child: myWidget,
    );
  }
}
