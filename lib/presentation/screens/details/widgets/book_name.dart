import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../controllers/books_controller.dart';
import '/core/utils/constants/extensions.dart';

class BookName extends StatelessWidget {
  BookName({super.key});
  final currentCollection = sl<BooksController>().currentCollection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: book_name(
              context, '${currentCollection.bookNumber}', context.textDarkColor,
              height: 90),
        ),
        Text(
          currentCollection.arAndEnName,
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
