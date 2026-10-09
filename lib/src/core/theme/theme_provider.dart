import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'app_theme_extension.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// Convenience provider for the extension — use this in widgets
final appThemeProvider = Provider<AppThemeExtension>((ref) {
  // You can expand this to read actual brightness if needed
  return AppThemeExtension.light; // fallback; widgets should use Theme.of(context)
});