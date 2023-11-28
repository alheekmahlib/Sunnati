import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/utils/constants/lists.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import '../details/details_screen.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              booksList.length,
              (index) => AnimationLimiter(
                child: AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 450),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        child: Container(
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
                                        booksList[index]['name'],
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
                              Text(
                                booksList[index]['name'],
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'kufi',
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                textAlign: TextAlign.justify,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Navigator.of(context)
                            .push(animatRoute(DetailsScreen(
                          arAndEnName: '${booksList[index]['arAndEnName']}',
                          bookName: '${booksList[index]['bookName']}',
                          bookDetails: '${booksList[index]['details']}',
                          bookNumber: index,
                        ))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
