// lib/src/common_widgets/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/routing/navigation_provider.dart';
import '../../features/home/home_page.dart';
import '../../features/inventory/view/inventory_screen.dart';
import '../../features/market/view/market_screen.dart';
import '../../features/zakat/view/zakat_screen.dart';
import 'bottom_navbar.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigationProvider);

    return Scaffold(
      body: _getScreenForTab(navState.selectedTab),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _getScreenForTab(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return const HomePage();
      case AppTab.inventory:
        return const InventoryScreen();
      case AppTab.zakat:
        return const ZakatScreen();
      case AppTab.market:
        return const MarketScreen();
    }
  }
}