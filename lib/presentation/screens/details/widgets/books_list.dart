import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/beige_container.dart';
import '../../../../core/widgets/white_container.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../books/read_view.dart';

class BooksList extends StatelessWidget {
  BooksList({super.key});
  final booksCtrl = sl<BooksController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final booksNames = booksCtrl.currentCollection.booksNames.toList();
    return BeigeContainer(
      myWidget: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: booksNames.length ?? 0,
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
                    child: WhiteContainer(
                      myWidget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          booksNames[i].bookName, //ToDo
                          // '',
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
                ],
              ),
              onTap: () {
                booksCtrl.currentBookNumber =
                    int.parse(booksNames[i].bookNumber); //ToDo
                Get.to(const ReadView(), transition: Transition.downToUp);
              },
            );
          }),
      width: orientation(context, width, 381.0),
    );
  }
}
