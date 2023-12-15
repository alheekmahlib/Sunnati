import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunti/presentation/controllers/general_controller.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/extensions.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import 'widgets/book_other_name.dart';
import 'widgets/chapter_title.dart';

// read hadiths inside the book and chapters
class ReadView extends StatelessWidget {
  const ReadView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: sunti_icon(context, height: 25, color: context.surfaceDarkColor),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Theme.of(context).primaryColor,
        leading: GestureDetector(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: sl<GeneralController>().checkWidgetRtlLayout(arrow_back(
                  context,
                  width: 26,
                  color: context.surfaceDarkColor))),
          onTap: () => Navigator.pop(context),
        ),
        actions: [fontSizeDropDown(context)],
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: height,
              width: width,
              padding: orientation(context, const EdgeInsets.all(0),
                  const EdgeInsets.only(right: 40.0, left: 40.0, bottom: 16.0)),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [BookOtherName(), ChapterTitle()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
