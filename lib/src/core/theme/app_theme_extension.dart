import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color gold;
  final Color goldSurface;
  final Color cardBackground;
  final Color textPrimary;
  final Color textSecondary;

  const AppThemeExtension({
    required this.gold,
    required this.goldSurface,
    required this.cardBackground,
    required this.textPrimary,
    required this.textSecondary,
  });

  static const light = AppThemeExtension(
    gold:            AppColors.goldDark,
    goldSurface:     AppColors.goldSurface,
    cardBackground:  AppColors.surfaceLight,
    textPrimary:     AppColors.textPrimary,
    textSecondary:   Color(0xFF6B6B6B),
  );

  static const dark = AppThemeExtension(
    gold:            AppColors.goldLight,
    goldSurface:     AppColors.goldSurfaceDark,
    cardBackground:  AppColors.cardDark,
    textPrimary:     Color(0xFFF0ECE0),
    textSecondary:   Color(0xFF9E9E9E),
  );

  @override
  AppThemeExtension copyWith({
    Color? gold, Color? goldSurface, Color? cardBackground,
    Color? textPrimary, Color? textSecondary,
  }) => AppThemeExtension(
    gold:           gold ?? this.gold,
    goldSurface:    goldSurface ?? this.goldSurface,
    cardBackground: cardBackground ?? this.cardBackground,
    textPrimary:    textPrimary ?? this.textPrimary,
    textSecondary:  textSecondary ?? this.textSecondary,
  );

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other == null) return this;
    return AppThemeExtension(
      gold:           Color.lerp(gold, other.gold, t)!,
      goldSurface:    Color.lerp(goldSurface, other.goldSurface, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      textPrimary:    Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary:  Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}