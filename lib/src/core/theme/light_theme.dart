import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme_extension.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF8F6F0),
  colorScheme: const ColorScheme.light(
    primary: AppColors.goldDark,
    secondary: AppColors.goldLight,
    surface: AppColors.surfaceLight,
  ),
  extensions: const [AppThemeExtension.light],
);