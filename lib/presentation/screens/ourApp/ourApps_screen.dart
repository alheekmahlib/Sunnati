import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sunti/core/utils/constants/extensions.dart';
import 'package:sunti/presentation/controllers/ourApps_controller.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import 'data/models/ourApp_model.dart';

class OurApps extends StatelessWidget {
  const OurApps({super.key});

  @override
  Widget build(BuildContext context) {
    sl<OurAppsController>().fetchApps();
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).id == 'dark'
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).canvasColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(300, -10),
              child: Opacity(
                opacity: .05,
                child: sunti_logo(
                  context,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: container(
                context,
                ourAppBuild(context),
                false,
                height: orientation(context, 450.0.h, 300.0.h),
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Transform.translate(
                    offset: orientation(
                        context, Offset(0, -200.h), Offset(0, -130.h)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sunti_logo(
                          context,
                          width: 80.0.w,
                        ),
                        const Gap(16),
                        beigeContainer(
                            context,
                            whiteContainer(
                              context,
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'فعليكم بسُنَّتي وسُنَّةِ الخُلَفاءِ الرَّاشِدينَ المَهْدِيِّينَ',
                                  style: TextStyle(
                                      fontFamily: 'kufi',
                                      color: Color(0xff3C2A21),
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            width: 300.0),
                      ],
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: orientation(
                    context,
                    const EdgeInsets.symmetric(vertical: 64.0).r,
                    const EdgeInsets.symmetric(vertical: 32.0).r),
                child: alheekmah_logo(
                  context,
                  width: 80.w,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.only(top: 48.0, right: 16.0).r,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: arrow_back(
                      context,
                      width: 26,
                      color: context.surfaceDarkColor,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget ourAppBuild(BuildContext context) {
    final ourApps = sl<OurAppsController>();
    return FutureBuilder<List<OurAppInfo>>(
      future: ourApps.fetchApps(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<OurAppInfo>? apps = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(top: 130.0).r,
            child: Column(
              children: [
                Text(
                  'ourApps'.tr,
                  style: TextStyle(
                      color: context.surfaceDarkColor,
                      fontSize: 20.sp,
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.bold),
                ),
                hDivider(context),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: false,
                    padding: EdgeInsets.zero,
                    itemCount: apps!.length,
                    separatorBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0).r,
                      child: hDivider(
                        context,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      // if (index >= 2) {
                      //   index++;
                      // }
                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)).r),
                          padding: const EdgeInsets.all(8.0).r,
                          margin:
                              const EdgeInsets.symmetric(horizontal: 16.0).r,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.network(
                                apps[index].appLogo,
                                height: 50.h,
                                width: 50.h,
                              ),
                              vDivider(context, height: 40.0.h),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      apps[index].appTitle,
                                      style: TextStyle(
                                          color: context.surfaceDarkColor,
                                          fontSize: 13.sp,
                                          fontFamily: 'kufi',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8.0.h,
                                    ),
                                    Text(
                                      apps[index].body,
                                      style: TextStyle(
                                          color: context.surfaceDarkColor
                                              .withOpacity(.7),
                                          fontSize: 10.sp,
                                          fontFamily: 'kufi',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          ourApps.launchURL(context, index, apps[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return loading(width: 200.0, height: 200.0);
      },
    );
  }
}
