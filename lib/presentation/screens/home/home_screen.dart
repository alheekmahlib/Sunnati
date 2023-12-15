import 'package:flutter/material.dart';
import 'package:sunti/presentation/controllers/onboarding_controller.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/widgets/widgets.dart';
import 'widgets/daily_hadith.dart';
import 'widgets/hijri_date.dart';
import 'widgets/last_read.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<OnboardingController>().startOnboarding();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Container(
          margin: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: orientation(
                context,
                ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    HijriDate(),
                    LastRead(),
                    DailyHadith(),
                    SizedBox(
                      height: 32.0,
                    )
                  ],
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    Row(
                      children: [
                        Expanded(child: LastRead()),
                        SizedBox(
                          width: 32.0,
                        ),
                        Expanded(child: HijriDate()),
                      ],
                    ),
                    DailyHadith(),
                    SizedBox(
                      height: 32.0,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
