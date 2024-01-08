import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/lists.dart';
import '../../../controllers/books_controller.dart';
import '../../../controllers/search_controller.dart';
import 'check_box_tile.dart';

class GroupButtonWidget extends StatelessWidget {
  const GroupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupButton(
      controller: sl<SearchControllers>().checkboxesController,
      isRadio: false,
      options: const GroupButtonOptions(
        groupingType: GroupingType.column,
      ),
      buttons: booksList,
      buttonIndexedBuilder: (selected, index, context) {
        return CheckBoxTile(
          title: booksList[index]['name'],
          selected: selected,
          onTap: () {
            if (!selected) {
              sl<SearchControllers>()
                ..selectCollectionById(sl<BooksController>()
                    .getCollectionIdByAuthorName(booksList[index]['name']))
                ..checkboxesController.selectIndex(index);

              return;
            }
            sl<SearchControllers>()
              ..unslectCollectionById(sl<BooksController>()
                  .getCollectionIdByAuthorName(booksList[index]['name']))
              ..checkboxesController.unselectIndex(index);
          },
        );
      },
      onSelected: (val, i, selected) {
        debugPrint('Button: $val index: $i $selected');
      },
    );
  }
}
