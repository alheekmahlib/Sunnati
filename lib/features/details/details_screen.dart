import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:sunti/features/books/read_view.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../core/services/controllers/searchController.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/constants/svg_picture.dart';
import '../search/screen/search_screen.dart';
import '../widgets/widgets.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green, // Set status bar color
    ));
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
                    Search(),
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: book_name(context, bookName, context.textDarkColor,
                    height: 90),
              ),
              Text(
                arAndEnName,
                style: TextStyle(
                  fontFamily: 'kufi',
                  fontSize: 18,
                  color: ThemeProvider.themeOf(context).id == 'dark'
                      ? Colors.white
                      : Theme.of(context).primaryColorDark,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: beigeContainer(
                  context,
                  ExpansionTileCard(
                    elevation: 0.0,
                    initialElevation: 0.0,
                    expandedTextColor: context.textDarkColor,
                    title: SizedBox(
                      width: 100.0,
                      child: Text(
                        'عن الكتاب',
                        style: TextStyle(
                          fontFamily: 'kufi',
                          fontSize: 16,
                          color: ThemeProvider.themeOf(context).id == 'dark'
                              ? Colors.white
                              : Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    baseColor: Theme.of(context).colorScheme.background,
                    expandedColor: Theme.of(context).colorScheme.background,
                    children: <Widget>[
                      const Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 42.0,
                          buttonMinWidth: 90.0,
                          children: [
                            Text(
                              bookDetails,
                              style: TextStyle(
                                fontFamily: 'naskh',
                                fontSize: 20,
                                color:
                                    ThemeProvider.themeOf(context).id == 'dark'
                                        ? Colors.white
                                        : Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  width: orientation(context, width, 381.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: beigeContainer(
                  context,
                  Column(
                    children: List.generate(
                        20,
                        (index) => GestureDetector(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Icon(
                                    Icons.list,
                                    size: 20,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                                  Expanded(
                                    flex: 8,
                                    child: whiteContainer(
                                      context,
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          ' كتاب بدء الوحي $index',
                                          style: TextStyle(
                                            fontFamily: 'naskh',
                                            fontSize: 20,
                                            color:
                                                ThemeProvider.themeOf(context)
                                                            .id ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.of(context)
                                  .push(animatRoute(ReadView(
                                title: ' كتاب بدء الوحي',
                                bookName: arAndEnName,
                                bookNumber: '$bookNumber',
                                bookOtherNumber: bookName,
                              ))),
                            )),
                  ),
                  width: orientation(context, width, 381.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
