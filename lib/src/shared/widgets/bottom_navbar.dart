// lib/shared/widgets/bottom_navbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/routing/navigation_provider.dart';
import '../../core/theme/app_theme_extension.dart';

class BottomNavBar extends ConsumerWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onInventoryTap;
  final VoidCallback? onZakatTap;
  final VoidCallback? onMarketTap;

  const BottomNavBar({
    super.key,
    this.onHomeTap,
    this.onInventoryTap,
    this.onZakatTap,
    this.onMarketTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigationProvider);
    final themeExt = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
                isSelected: navState.selectedTab == AppTab.home,
                selectedColor: themeExt.gold,
                onTap: () {
                  ref.read(navigationProvider.notifier).selectTab(AppTab.home);
                  onHomeTap?.call();
                },
              ),
              _NavItem(
                icon: Icons.inbox_outlined,
                selectedIcon: Icons.inbox,
                label: 'Inventory',
                isSelected: navState.selectedTab == AppTab.inventory,
                selectedColor: themeExt.gold,
                onTap: () {
                  ref.read(navigationProvider.notifier).selectTab(AppTab.inventory);
                  onInventoryTap?.call();
                },
              ),
              _NavItem(
                icon: Icons.calculate_outlined,
                selectedIcon: Icons.calculate,
                label: 'Zakat',
                isSelected: navState.selectedTab == AppTab.zakat,
                selectedColor: themeExt.gold,
                onTap: () {
                  ref.read(navigationProvider.notifier).selectTab(AppTab.zakat);
                  onZakatTap?.call();
                },
              ),
              _NavItem(
                icon: Icons.trending_up_outlined,
                selectedIcon: Icons.trending_up,
                label: 'Market',
                isSelected: navState.selectedTab == AppTab.market,
                selectedColor: themeExt.gold,
                onTap: () {
                  ref.read(navigationProvider.notifier).selectTab(AppTab.market);
                  onMarketTap?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? selectedColor : unselectedColor,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}