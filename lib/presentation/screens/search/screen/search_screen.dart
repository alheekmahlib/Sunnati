import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/lottie.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/search_controller.dart';
import '../widgets/search_options.dart';
import '../widgets/search_result_item.dart';
import '/core/utils/constants/extensions.dart';

class Search extends StatelessWidget {
  Search({super.key});

  final TextEditingController textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, 1),
              child: button_curve(context),
            ),
            GestureDetector(
              child: close(context, height: 30.0),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
        Flexible(
          child: orientation(
              context,
              Flexible(
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      children: [
                        Text(
                          'search'.tr,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'kufi',
                            fontWeight: FontWeight.w600,
                            color: context.surfaceDarkColor,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 50,
                                width: orientation(
                                    context,
                                    MediaQuery.sizeOf(context).width * .7,
                                    MediaQuery.sizeOf(context).width * .5),
                                child: TextField(
                                  controller: textSearchController,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'kufi',
                                    fontWeight: FontWeight.w600,
                                    color:
                                        context.textDarkColor.withOpacity(.7),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'searchHintText'.tr,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'kufi',
                                      fontWeight: FontWeight.w600,
                                      color:
                                          context.textDarkColor.withOpacity(.3),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                    prefixIcon: Container(
                                      height: 20,
                                      padding: const EdgeInsets.all(10.0),
                                      child: search(context),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: context.textDarkColor,
                                      ),
                                      onPressed: () {
                                        textSearchController.clear();
                                      },
                                    ),
                                    labelText: 'searchHintText'.tr,
                                    labelStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'kufi',
                                      fontWeight: FontWeight.w600,
                                      color:
                                          context.textDarkColor.withOpacity(.5),
                                    ),
                                  ),
                                  onSubmitted: (query) async {
                                    await sl<SearchControllers>()
                                        .addSearchItem(query);
                                    textSearchController.clear();
                                  },
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: setting_lines(context),
                                ),
                                onTap: () {
                                  optionsModalBottomSheet(
                                      context, const SearchOptions(),
                                      height: orientation(context, height * .8,
                                          platformView(height, height * .5)));
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 5,
                          width: MediaQuery.sizeOf(context).width,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                              color: context.textDarkColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'results'.tr,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'kufi',
                                color: context.surfaceDarkColor,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return sl<SearchControllers>().searchResults.isEmpty
                              ? Text('Opps.. No Maching Results!',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'kufi',
                                    color: context.surfaceDarkColor,
                                  ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sl<SearchControllers>()
                                      .searchResults
                                      .length,
                                  itemBuilder: (context, index) {
                                    final item = sl<SearchControllers>()
                                        .searchResults[index];
                                    return Text(
                                      item.hadithText
                                          .replaceAll(RegExp(r'<[^>]*>'), ''),
                                      // RegExp(r'<[^>]*>"')
                                      //         .firstMatch(item.hadithText)
                                      //         .toString() ??
                                      //     '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'kufi',
                                        color: context.surfaceDarkColor,
                                      ),
                                    );
                                    // return SearchResultItem(
                                    //     item: SearchItem(
                                    //         item.hadithText,
                                    //         DateTime.now()
                                    //             .millisecondsSinceEpoch
                                    //             .toString()));
                                  },
                                );
                        }),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'lastSearch'.tr,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'kufi',
                                color: context.surfaceDarkColor,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return sl<SearchControllers>().searchHistory.isEmpty
                              ? searchLoading(height: 100.0)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sl<SearchControllers>()
                                      .searchHistory
                                      .length,
                                  itemBuilder: (context, index) {
                                    final item = sl<SearchControllers>()
                                        .searchHistory[index];
                                    return SearchResultItem(item: item);
                                  },
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'search'.tr,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'kufi',
                                  fontWeight: FontWeight.w600,
                                  color: context.surfaceDarkColor,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: textSearchController,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'kufi',
                                    fontWeight: FontWeight.w600,
                                    color:
                                        context.textDarkColor.withOpacity(.7),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'searchHintText'.tr,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'kufi',
                                      fontWeight: FontWeight.w600,
                                      color:
                                          context.textDarkColor.withOpacity(.3),
                                    ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                    prefixIcon: Container(
                                      height: 20,
                                      padding: const EdgeInsets.all(10.0),
                                      child: search(context),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: context.textDarkColor,
                                      ),
                                      onPressed: () {
                                        textSearchController.clear();
                                      },
                                    ),
                                    labelText: 'searchHintText'.tr,
                                    labelStyle: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'kufi',
                                      fontWeight: FontWeight.w600,
                                      color:
                                          context.textDarkColor.withOpacity(.5),
                                    ),
                                  ),
                                  onSubmitted: (query) async {
                                    await sl<SearchControllers>()
                                        .addSearchItem(query);
                                    textSearchController.clear();
                                  },
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                            ),
                            const Gap(16),
                            const Expanded(flex: 8, child: SearchOptions()),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: context.textDarkColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'results'.tr,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'kufi',
                                color: context.surfaceDarkColor,
                              ),
                            ),
                          ),
                          Obx(() {
                            return sl<SearchControllers>().searchResults.isEmpty
                                ? Text('Opps.. No Maching Results!',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'kufi',
                                      color: context.surfaceDarkColor,
                                    ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: sl<SearchControllers>()
                                        .searchResults
                                        .length,
                                    itemBuilder: (context, index) {
                                      final item = sl<SearchControllers>()
                                          .searchResults[index];
                                      return Text(
                                        item.hadithText
                                            .replaceAll(RegExp(r'<[^>]*>'), ''),
                                        // RegExp(r'<[^>]*>"')
                                        //         .firstMatch(item.hadithText)
                                        //         .toString() ??
                                        //     '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'kufi',
                                          color: context.surfaceDarkColor,
                                        ),
                                      );
                                      // return SearchResultItem(
                                      //     item: SearchItem(
                                      //         item.hadithText,
                                      //         DateTime.now()
                                      //             .millisecondsSinceEpoch
                                      //             .toString()));
                                    },
                                  );
                          }),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'lastSearch'.tr,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'kufi',
                                  color: context.surfaceDarkColor,
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            return sl<SearchControllers>().searchHistory.isEmpty
                                ? searchLoading(height: 100.0)
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: sl<SearchControllers>()
                                        .searchHistory
                                        .length,
                                    itemBuilder: (context, index) {
                                      final item = sl<SearchControllers>()
                                          .searchHistory[index];
                                      return SearchResultItem(item: item);
                                    },
                                  );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
