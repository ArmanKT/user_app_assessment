import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  // Direct access to ThemeData
  ThemeData get theme => Theme.of(this);

  // Colors
  Color get primaryColor => theme.primaryColor;
  Color get secondaryColor => theme.colorScheme.secondary;
  Color get backgroundColor => theme.scaffoldBackgroundColor;
  Color get errorColor => theme.colorScheme.error;
  Color get surfaceColor => theme.colorScheme.surface;

  // Text styles
  TextStyle get displayLarge => theme.textTheme.displayLarge!;
  TextStyle get displayMedium => theme.textTheme.displayMedium!;
  TextStyle get displaySmall => theme.textTheme.displaySmall!;
  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;
  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodySmall => theme.textTheme.bodySmall!;
  TextStyle get labelLarge => theme.textTheme.labelLarge!;
  TextStyle get labelMedium => theme.textTheme.labelMedium!;
  TextStyle get labelSmall => theme.textTheme.labelSmall!;
}
