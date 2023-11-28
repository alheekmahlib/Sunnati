import 'package:flutter/material.dart';
import '/core/utils/constants/extensions.dart';

class BookOtherName extends StatelessWidget {
  final String title;
  const BookOtherName({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'naskh',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: context.surfaceDarkColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
