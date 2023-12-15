import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../books/read_view.dart';

class BooksList extends StatelessWidget {
  BooksList({super.key});
  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final booksNames = booksCtrl.currentCollection.booksNames;
    return beigeContainer(
      context,
      ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: booksNames.length,
          itemBuilder: (context, i) {
            return GestureDetector(
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            booksNames[i]['book_name'],
                            style: TextStyle(
                              fontFamily: 'naskh',
                              fontSize: 20,
                              color: ThemeProvider.themeOf(context).id == 'dark'
                                  ? Colors.white
                                  : Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                booksCtrl.currentBookNumber =
                    int.tryParse(booksNames[i]['book_number']) ?? 404;
                Navigator.of(context).push(animatRoute(
                  const ReadView(),
                ));
              },
            );
          }),
      width: orientation(context, width, 381.0),
    );
  }
}
