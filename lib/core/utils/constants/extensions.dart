import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

extension Dimensions on BuildContext {
  Color get textDarkColor => ThemeProvider.themeOf(this).id == 'dark'
      ? Colors.white
      : Theme.of(this).primaryColorDark;

  Color get titleDarkColor => ThemeProvider.themeOf(this).id == 'dark'
      ? Theme.of(this).primaryColorDark
      : Theme.of(this).colorScheme.surface;

  Color get beigeDarkColor => ThemeProvider.themeOf(this).id == 'dark'
      ? Theme.of(this).primaryColor
      : Theme.of(this).colorScheme.surface;

  Color get surfaceDarkColor => ThemeProvider.themeOf(this).id == 'dark'
      ? Theme.of(this).colorScheme.surface
      : Theme.of(this).primaryColorDark;

  Color get iconsDarkColor => ThemeProvider.themeOf(this).id == 'dark'
      ? Theme.of(this).colorScheme.surface
      : Theme.of(this).colorScheme.surface;
}
