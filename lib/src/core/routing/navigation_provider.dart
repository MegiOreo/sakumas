// lib/src/routing/navigation_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';

enum AppTab {
  home,
  inventory,
  zakat,
  market,
}

class NavigationState {
  final AppTab selectedTab;

  const NavigationState({required this.selectedTab});

  NavigationState copyWith({AppTab? selectedTab}) {
    return NavigationState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class NavigationNotifier extends Notifier<NavigationState> {
  @override
  NavigationState build() {
    return const NavigationState(selectedTab: AppTab.home);
  }

  void selectTab(AppTab tab) {
    if (state.selectedTab == tab) return;
    state = state.copyWith(selectedTab: tab);
  }
}

final navigationProvider = NotifierProvider<NavigationNotifier, NavigationState>(() {
  return NavigationNotifier();
});