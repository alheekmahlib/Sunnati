import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../../core/services/controllers/bookmark_controller.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/extensions.dart';
import '../../widgets/widgets.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({super.key});

  @override
  Widget build(BuildContext context) {
    var bookmark = sl<BookmarkController>().bookmark;
    return Padding(
      padding: orientation(context, const EdgeInsets.all(0),
          const EdgeInsets.symmetric(horizontal: 40.0)),
      child: Column(
          children: List.generate(
        sl<BookmarkController>().bookmark.length,
        (bookNameIndex) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: beigeContainer(
            context,
            Column(
              children: [
                Text(
                  bookmark[bookNameIndex].bookName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'kufi',
                    fontWeight: FontWeight.w600,
                    color: context.surfaceDarkColor,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Column(
                    children: List.generate(
                  /// TODO
                  1,
                  (bookOtherNameIndex) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ExpansionTileCard(
                        elevation: 0.0,
                        initialElevation: 0.0,
                        expandedTextColor: Theme.of(context).primaryColorDark,
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: Icon(
                              Icons.list,
                              size: 20,
                              color: Theme.of(context).primaryColorDark,
                            )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                bookmark[bookOtherNameIndex].bookOtherName,
                                style: TextStyle(
                                  fontFamily: 'naskh',
                                  fontSize: 20,
                                  color: context.surfaceDarkColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        baseColor: Theme.of(context).primaryColorLight,
                        expandedColor: Theme.of(context).primaryColorLight,
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
                              Column(

                                  /// عدد الأحاديث المحفوظة
                                  children: List.generate(
                                /// TODO
                                1,
                                (chapterIndex) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: beigeContainer(
                                          context,
                                          Center(
                                            child: Text(
                                              bookmark[chapterIndex]
                                                  .chapterTitle,
                                              style: TextStyle(
                                                fontFamily: 'naskh',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: context.textDarkColor,
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.sizeOf(context).width),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        bookmark[chapterIndex].hadith,
                                        style: TextStyle(
                                          fontFamily: 'naskh',
                                          fontSize: 20,
                                          color: context.textDarkColor,
                                        ),
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ]),
                  ),
                ))
              ],
            ),
            width: MediaQuery.sizeOf(context).width,
          ),
        ),
      )),
    );
  }
}
