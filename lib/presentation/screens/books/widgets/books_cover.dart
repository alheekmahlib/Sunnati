import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../details/details_screen.dart';
import '../data/models/book_model.dart';

class BooksCover extends StatelessWidget {
  final String title;
  final int length;
  final int adjustedIndex;
  const BooksCover(
      {super.key,
      required this.title,
      required this.length,
      required this.adjustedIndex});

  @override
  Widget build(BuildContext context) {
    final booksCtrl = sl<BooksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'kufi',
              fontWeight: FontWeight.w600,
              color: context.surfaceDarkColor,
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(
            length,
            (index) {
              adjustedIndex + index;
              if (adjustedIndex >= booksCtrl.allBooks.length) {
                return const SizedBox.shrink();
              }
              final Book book = booksCtrl.allBooks[adjustedIndex + index];

              return Column(
                children: [
                  AnimationLimiter(
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 450),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            child: Container(
                              width: 90,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              padding: const EdgeInsets.only(bottom: 12.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  )),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      book_cover(
                                        context,
                                        height: 130.0,
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, 30),
                                        child: SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Text(
                                            book.bookName,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'kufi',
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                            ),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      book.bookName,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'kufi',
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              sl<BooksController>().currentBookIndex = index;
                              Navigator.of(context)
                                  .push(animatRoute(DetailsScreen()));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
