import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/books_controller.dart';
import '../../books/read_view.dart';

class BooksList extends StatelessWidget {
  const BooksList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return beigeContainer(
      context,
      FutureBuilder<int>(
          future: sl<BooksController>().getBooksLength(),
          builder: (context, snap) {
            return snap.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Column(
                    children: List.generate(
                        snap.data!,
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
                                          // ' كتاب بدء الوحي $index', TODO get the book name
                                          'Book Name $index',
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
                                  .push(animatRoute(ReadView())),
                            )),
                  );
          }),
      width: orientation(context, width, 381.0),
    );
  }
}
