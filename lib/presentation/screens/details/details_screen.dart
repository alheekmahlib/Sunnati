import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/search_controller.dart';
import '../search/screen/search_screen.dart';
import '/core/utils/constants/extensions.dart';
import 'widgets/about_book.dart';
import 'widgets/book_name.dart';
import 'widgets/chapter_list.dart';

class DetailsScreen extends StatelessWidget {
  final String arAndEnName;
  final String bookName;
  final String bookDetails;
  final int bookNumber;
  const DetailsScreen(
      {super.key,
      required this.arAndEnName,
      required this.bookName,
      required this.bookDetails,
      required this.bookNumber});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: sunti_icon(context, height: 25, color: context.iconsDarkColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Theme.of(context).primaryColorDark,
          leading: GestureDetector(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: arrow_back(
                  context,
                  width: 26,
                  color: context.iconsDarkColor,
                )),
            onTap: () => Navigator.pop(context),
          ),
          leadingWidth: 58,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                child: search(context),
                onTap: () {
                  sl<SearchControllers>().booksSelected = [bookNumber];
                  screenModalBottomSheet(
                    context,
                    const Search(),
                  );
                },
              ),
            )
          ],
        ),
        body: Container(
            height: height,
            width: width,
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: orientation(
              context,
              ListView(
                children: [
                  BookName(bookNumber: bookNumber, arAndEnName: arAndEnName),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: AboutBook(
                      bookDetails: bookDetails,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: ChapterList(
                          arAndEnName: arAndEnName,
                          bookNumber: bookNumber,
                          bookName: bookName))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: SingleChildScrollView(
                            child: ChapterList(
                                arAndEnName: arAndEnName,
                                bookNumber: bookNumber,
                                bookName: bookName),
                          )),
                    ),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BookName(
                                bookNumber: bookNumber,
                                arAndEnName: arAndEnName),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: AboutBook(
                                bookDetails: bookDetails,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
