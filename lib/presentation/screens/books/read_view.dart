import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/constants/extensions.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import 'widgets/book_other_name.dart';
import 'widgets/chapter_title.dart';

class ReadView extends StatelessWidget {
  final String bookName;
  final String bookOtherNumber;
  final int bookNumber;
  const ReadView({
    super.key,
    required this.bookName,
    required this.bookOtherNumber,
    required this.bookNumber,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:
              sunti_icon(context, height: 25, color: context.surfaceDarkColor),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: arrow_back(context,
                    width: 26, color: context.surfaceDarkColor)),
            onTap: () => Navigator.pop(context),
          ),
          leadingWidth: 58,
          actions: [
            fontSizeDropDown(context),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Container(
                height: height,
                width: width,
                padding: orientation(
                    context,
                    const EdgeInsets.all(0),
                    const EdgeInsets.only(
                        right: 40.0, left: 40.0, bottom: 16.0)),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BookOtherName(
                        title: bookOtherNumber,
                      ),
                      ChapterTitle(
                        bookName: bookName,
                        bookOtherNumber: bookOtherNumber,
                        chapterName: 'باب',
                        bookNumber: bookNumber,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
