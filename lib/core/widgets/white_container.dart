import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final Widget myWidget;
  final double? height;
  final double? width;
  const WhiteContainer(
      {super.key, required this.myWidget, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          )),
      child: myWidget,
    );
  }
}
