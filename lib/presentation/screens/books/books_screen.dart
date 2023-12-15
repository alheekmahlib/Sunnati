import 'package:flutter/material.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../core/utils/constants/lists.dart';
import 'widgets/books_cover.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: context.beigeDarkColor.withOpacity(.6),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        )),
                    child:
                        BooksCover(title: Constants.collectionsGroupsTitles[0]),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: context.beigeDarkColor.withOpacity(.4),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        )),
                    child:
                        BooksCover(title: Constants.collectionsGroupsTitles[1]),
                  ),
                  BooksCover(title: Constants.collectionsGroupsTitles[2]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
