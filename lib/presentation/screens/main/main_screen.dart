import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/extensions.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/settings_list.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/searchController.dart';
import '../../controllers/settings_controller.dart';
import '../bookmark/bookmarks_screen.dart';
import '../books/books_screen.dart';
import '../home/home_screen.dart';
import '../search/screen/search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    sl<SettingsController>().loadLang();
    sl<GeneralController>().updateGreeting();
    bool isNeedSafeArea = MediaQuery.viewPaddingOf(context).bottom > 0;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        extendBody: false,
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Padding(
          padding: orientation(
              context,
              isNeedSafeArea
                  ? const EdgeInsets.only(top: 64.0)
                  : const EdgeInsets.only(top: 16.0),
              const EdgeInsets.all(0)),
          child: SliderDrawer(
            key: sl<GeneralController>().key,
            splashColor: Theme.of(context).primaryColorDark,
            slideDirection: orientation(context, SlideDirection.TOP_TO_BOTTOM,
                SlideDirection.LEFT_TO_RIGHT),
            sliderOpenSize: platformView(
                orientation(
                    context, height / 1 / 2 * 1.1, height / 1 / 2 * 1.5),
                height / 1 / 2 * 1.1),
            isCupertino: true,
            isDraggable: true,
            appBar: SliderAppBar(
              appBarColor: Theme.of(context).primaryColorDark,
              appBarPadding: orientation(
                  context,
                  const EdgeInsets.symmetric(horizontal: 16.0),
                  const EdgeInsets.symmetric(horizontal: 40.0)),
              drawerIconColor: Theme.of(context).colorScheme.secondary,
              drawerIcon: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 24.h,
                  color: Theme.of(context).colorScheme.surface,
                ),
                onPressed: () =>
                    sl<GeneralController>().key.currentState?.toggle(),
              ),
              appBarHeight: 40.h,
              title: Container(),
              trailing: sunti_icon(context,
                  height: 20, color: context.iconsDarkColor),
            ),
            slider: const SettingsList(),
            child: PageView(
              controller: sl<GeneralController>().controller,
              onPageChanged: (index) {
                sl<GeneralController>().selected.value = index;
                print('selected ${sl<GeneralController>().selected.value}');
              },
              children: [
                const HomeScreen(),
                const Books(),
                BookmarksScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => StylishBottomBar(
            items: [
              BottomBarItem(
                icon: Opacity(
                    opacity:
                        sl<GeneralController>().selected.value == 0 ? 1 : .5,
                    child: home(context)),
                selectedIcon: home(context),
                // selectedColor: Colors.teal,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Text(
                  'home'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'kufi',
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              BottomBarItem(
                icon: Opacity(
                    opacity:
                        sl<GeneralController>().selected.value == 1 ? 1 : .5,
                    child: books(context)),
                selectedIcon: books(context),
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Text(
                  'books'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'kufi',
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              BottomBarItem(
                  icon: Opacity(
                      opacity:
                          sl<GeneralController>().selected.value == 2 ? 1 : .5,
                      child: bookmark(context)),
                  selectedIcon: bookmark(context),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  title: Text(
                    'bookmark'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'kufi',
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  )),
            ],
            hasNotch: true,
            fabLocation: StylishBarFabLocation.end,
            currentIndex: sl<GeneralController>().selected.value,
            onTap: (index) {
              sl<GeneralController>().controller.jumpToPage(index);
              sl<GeneralController>().selected.value = index;
            },
            option: AnimatedBarOptions(
              barAnimation: BarAnimation.liquid,
              iconStyle: IconStyle.animated,
            ),
            backgroundColor: Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            elevation: 80,
          ),
        ),
        floatingActionButton: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            onPressed: () {
              screenModalBottomSheet(
                context,
                Search(),
              );
              sl<SearchControllers>().booksSelected = [
                0,
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14
              ];
            },
            backgroundColor: Theme.of(context).primaryColorDark,
            child: search(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
