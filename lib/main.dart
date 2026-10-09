import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakumas/src/core/theme/dark_theme.dart';
import 'package:sakumas/src/core/theme/light_theme.dart';
import 'package:sakumas/src/core/theme/theme_provider.dart';
import 'package:sakumas/src/shared/widgets/main_scaffold.dart';


void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),

      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: const SplashScreen(),
      home: const MainScaffold(),
    );
  }
}