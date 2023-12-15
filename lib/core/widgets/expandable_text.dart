import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../presentation/controllers/general_controller.dart';
import '../services/services_locator.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    required this.text,
    Key? key,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxHeight = 70,
    this.textStyle,
    this.iconCollapsed,
    this.iconExpanded,
    this.textAlign = TextAlign.center,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
  }) : super(key: key);

  final String text;
  final String? readLessText;
  final String? readMoreText;
  final Duration animationDuration;
  final double maxHeight;
  final TextStyle? textStyle;
  final Widget? iconExpanded;
  final Widget? iconCollapsed;
  final TextAlign textAlign;
  final Color iconColor;
  final TextStyle? buttonTextStyle;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedSize(
          duration: widget.animationDuration,
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : BoxConstraints(maxHeight: widget.maxHeight),
            child: isExpanded
                ? SelectableText(
                    widget.text,
                    textAlign: widget.textAlign,
                    style: TextStyle(
                      fontSize:
                          sl<GeneralController>().fontSizeArabic.value - 10,
                      fontFamily: 'kufi',
                      color: ThemeProvider.themeOf(context).id == 'dark'
                          ? Colors.white
                          : Colors.black,
                      // overflow: TextOverflow.fade,
                    ),
                    textDirection: TextDirection.ltr,
                  )
                : ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.transparent.withOpacity(.1),
                          Colors.black.withOpacity(.1),
                          Colors.black,
                          Colors.transparent
                        ],
                        stops: const [0.0, 0.1, 1.0, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SelectableText(
                      widget.text,
                      textAlign: widget.textAlign,
                      style: TextStyle(
                        fontSize:
                            sl<GeneralController>().fontSizeArabic.value - 10,
                        fontFamily: 'kufi',
                        color: ThemeProvider.themeOf(context).id == 'dark'
                            ? Colors.white
                            : Colors.black,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(),
          child: TextButton.icon(
            icon: Text(
              isExpanded
                  ? widget.readLessText ?? 'Read less'
                  : widget.readMoreText ?? 'Read more',
              style: widget.buttonTextStyle ??
                  Theme.of(context).textTheme.titleMedium,
            ),
            label: isExpanded
                ? widget.iconExpanded ??
                    Icon(
                      Icons.arrow_drop_up,
                      color: widget.iconColor,
                    )
                : widget.iconCollapsed ??
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.iconColor,
                    ),
            onPressed: () => setState(() => isExpanded = !isExpanded),
          ),
        )
      ],
    );
  }
}
