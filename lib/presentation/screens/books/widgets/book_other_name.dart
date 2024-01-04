import 'package:flutter/material.dart';

import '../../../../core/services/services_locator.dart';
import '../../../controllers/books_controller.dart';
import '/core/utils/constants/extensions.dart';

class BookOtherName extends StatelessWidget {
  BookOtherName({super.key});
  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        booksCtrl.currentBookName,
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
