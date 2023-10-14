import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../core/utils/constants/svg_picture.dart';
import '/core/utils/constants/extensions.dart';

class BookName extends StatelessWidget {
  final String bookName;
  final String arAndEnName;
  const BookName(
      {super.key, required this.bookName, required this.arAndEnName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              book_name(context, bookName, context.textDarkColor, height: 90),
        ),
        Text(
          arAndEnName,
          style: TextStyle(
            fontFamily: 'kufi',
            fontSize: 18,
            color: ThemeProvider.themeOf(context).id == 'dark'
                ? Colors.white
                : Theme.of(context).primaryColorDark,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
