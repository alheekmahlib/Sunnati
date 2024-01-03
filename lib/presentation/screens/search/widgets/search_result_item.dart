import 'package:flutter/material.dart';

import '../../../controllers/search_controller.dart';
import '../data/models/search_model.dart';
import '/core/services/services_locator.dart';
import '/core/utils/constants/extensions.dart';
import '/core/utils/constants/svg_picture.dart';
import '/core/widgets/widgets.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.item,
  });

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: beigeContainer(
          context,
          whiteContainer(
            context,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      search(context),
                      customDivider(context, height: 25, width: 2),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.query,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'kufi',
                          fontWeight: FontWeight.w600,
                          color: context.textDarkColor.withOpacity(.7),
                        ),
                      ),
                      Text(
                        item.timestamp,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'kufi',
                          fontWeight: FontWeight.w600,
                          color: context.textDarkColor.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () =>
                          sl<SearchControllers>().removeSearchItem(item),
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: context.surfaceDarkColor,
                      )),
                )
              ],
            ),
          )),
    );
  }
}
