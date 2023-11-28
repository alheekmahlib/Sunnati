import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '/core/utils/constants/extensions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/lists.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/searchController.dart';
import 'check_box_tile.dart';

class SearchOptions extends StatelessWidget {
  const SearchOptions({super.key});

  @override
  Widget build(BuildContext context) {
    sl<SearchControllers>().checkboxesController = GroupButtonController(
      selectedIndexes: sl<SearchControllers>().booksSelected,
    );
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'books'.tr,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'kufi',
                    fontWeight: FontWeight.bold,
                    color: context.surfaceDarkColor,
                  ),
                ),
                GestureDetector(
                  child: close(context, height: 25.0),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Flexible(
            child: beigeContainer(
                context,
                ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GroupButton(
                        controller:
                            sl<SearchControllers>().checkboxesController,
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
                                    .checkboxesController
                                    .selectIndex(index);
                                return;
                              }
                              sl<SearchControllers>()
                                  .checkboxesController
                                  .unselectIndex(index);
                            },
                          );
                        },
                        onSelected: (val, i, selected) =>
                            debugPrint('Button: $val index: $i $selected'),
                      ),
                    ),
                  ],
                ),
                width: MediaQuery.sizeOf(context).width),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(context.surfaceDarkColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set the value as desired
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'save'.tr,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'kufi',
                  fontWeight: FontWeight.bold,
                  color: context.beigeDarkColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
