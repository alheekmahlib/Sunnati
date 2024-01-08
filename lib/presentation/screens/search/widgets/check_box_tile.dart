import 'package:flutter/material.dart';

import '../../../../core/widgets/white_container.dart';
import '/core/utils/constants/extensions.dart';

class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WhiteContainer(
        myWidget: Transform.translate(
          offset: const Offset(20, -7),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * .6,
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'kufi',
                  color: context.surfaceDarkColor,
                ),
              ),
              onTap: onTap,
              leading: Checkbox(
                value: selected,
                activeColor: context.surfaceDarkColor,
                checkColor: Theme.of(context).primaryColorLight,
                onChanged: (val) {
                  onTap();
                },
              ),
            ),
          ),
        ),
        height: 40,
        width: MediaQuery.sizeOf(context).width);
  }
}
