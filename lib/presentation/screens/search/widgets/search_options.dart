import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:sunti/presentation/screens/search/widgets/group_button.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/beige_container.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/search_controller.dart';
import '/core/utils/constants/extensions.dart';

class SearchOptions extends StatelessWidget {
  const SearchOptions({super.key});

  @override
  Widget build(BuildContext context) {
    sl<SearchControllers>().checkboxesController = GroupButtonController(
      selectedIndexes: sl<SearchControllers>().selectedCollections,
    );
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Padding(
            padding: orientation(context, const EdgeInsets.only(bottom: 32.0),
                const EdgeInsets.all(0)),
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
                orientation(
                    context,
                    GestureDetector(
                      child: close(context, height: 25.0),
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox.shrink())
              ],
            ),
          ),
          Flexible(
            child: BeigeContainer(
              myWidget: ListView(
                children: const [
                  GroupButtonWidget(),
                ],
              ),
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            // padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
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
