import 'package:flutter/material.dart';

import '../widgets/daily_hadith.dart';
import '../widgets/hijri_date.dart';
import '../widgets/last_read.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: ListView(
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
        ),
      ),
    );
  }
}
