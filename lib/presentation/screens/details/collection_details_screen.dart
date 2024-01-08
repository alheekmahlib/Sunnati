import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunti/presentation/controllers/general_controller.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/books_controller.dart';
import '../../controllers/search_controller.dart';
import '../search/screen/search_screen.dart';
import '/core/utils/constants/extensions.dart';
import 'widgets/about_book.dart';
import 'widgets/book_name.dart';
import 'widgets/books_list.dart';

class CollectionDetailsScreen extends StatelessWidget {
  CollectionDetailsScreen({super.key});
  final currentCollection = sl<BooksController>().currentCollection;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: sunti_icon(context, height: 25, color: context.iconsDarkColor),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Theme.of(context).primaryColorDark,
        leading: GestureDetector(
            onTap: Get.back,
            child: sl<GeneralController>().checkWidgetRtlLayout(
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: arrow_back(
                    context,
                    width: 26,
                    color: context.iconsDarkColor,
                  )),
            )),
        leadingWidth: 58,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              child: search(context),
              onTap: () {
                sl<SearchControllers>().selectedCollections = [
                  sl<BooksController>()
                      .getCollectionIdByAuthorName(currentCollection.bookName)
                ];
                Get.bottomSheet(Search(), isScrollControlled: true);
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
              primary: false,
              children: [
                BookName(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: AboutBook(),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: BooksList())
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: SingleChildScrollView(
                        child: BooksList(),
                      )),
                  SingleChildScrollView(
                    child: Flexible(
                      child: Column(
                        children: [
                          BookName(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: AboutBook(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
