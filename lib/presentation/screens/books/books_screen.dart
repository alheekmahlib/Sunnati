import 'package:flutter/material.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/widgets/widgets.dart';
import '/presentation/controllers/books_controller.dart';
import 'widgets/books_cover.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    final books = sl<BooksController>();
    books.loadData();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.only(top: 20.0),
          padding: orientation(
              context, null, const EdgeInsets.symmetric(horizontal: 40.0)),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: context.beigeDarkColor.withOpacity(.6),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                child: BooksCover(
                  title: 'الكتب الستة',
                  length: 6,
                  adjustedIndex: 0,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: orientation(
                    context,
                    const EdgeInsets.symmetric(horizontal: 32.0),
                    const EdgeInsets.symmetric(horizontal: 60.0)),
                decoration: BoxDecoration(
                    color: context.beigeDarkColor.withOpacity(.4),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    )),
                child: BooksCover(
                  title: 'الكتب التسعة',
                  length: 3,
                  adjustedIndex: 6,
                ),
              ),
              BooksCover(
                title: 'الكتب الآخرى',
                length: 6,
                adjustedIndex: 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
