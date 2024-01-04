import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sunti/core/utils/constants/extensions.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../details/collection_details_screen.dart';

class BooksCover extends StatelessWidget {
  final String title;

  BooksCover({super.key, required this.title});

  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    final collectionGroup = booksCtrl.getCollectionsGroupByTitle(title);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
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
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(
                collectionGroup.length,
                (index) {
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
                                      horizontal: 8.0, vertical: 16.0),
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
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
                                                collectionGroup[index].bookName,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'kufi',
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                ),
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          collectionGroup[index].bookName,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'kufi',
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          textAlign: TextAlign.justify,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  booksCtrl.currentCollctionId =
                                      collectionGroup[index].id;
                                  Navigator.of(context).push(
                                      animatRoute(CollectionDetailsScreen()));
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
          ),
        ],
      ),
    );
  }
}
