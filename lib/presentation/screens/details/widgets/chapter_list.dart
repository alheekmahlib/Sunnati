import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/widgets/widgets.dart';
import '../../books/read_view.dart';

class ChapterList extends StatelessWidget {
  final String arAndEnName;
  final int bookNumber;
  final String bookName;
  const ChapterList(
      {super.key,
      required this.arAndEnName,
      required this.bookNumber,
      required this.bookName});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return beigeContainer(
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
                                    ThemeProvider.themeOf(context).id == 'dark'
                                        ? Colors.white
                                        : Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () =>
                      Navigator.of(context).push(animatRoute(const ReadView())),
                )),
      ),
      width: orientation(context, width, 381.0),
    );
  }
}
