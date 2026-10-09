import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.surfaceDark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.goldLight,
    secondary: AppColors.goldDark,
    surface: AppColors.cardDark,
  ),
  extensions: const [AppThemeExtension.dark],
);