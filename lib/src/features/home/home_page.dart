// home_page.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme_extension.dart';
import 'home_viewmodel.dart';

extension BuildContextTheme on BuildContext {
  AppThemeExtension get appTheme =>
      Theme.of(this).extension<AppThemeExtension>()!;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    // Kick off initial data load
    _viewModel.loadUserGoldItems();
    _viewModel.fetchLatestGoldPrice();
  }

  @override
  void dispose() {
    _viewModel.dispose(); // ← required: ChangeNotifier must be disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder rebuilds only this subtree when ViewModel notifies.
    // Nothing else in the tree is affected.
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 32),
                  _GoldWorthCard(viewModel: _viewModel),
                  const SizedBox(height: 24),
                  _MetricsGrid(viewModel: _viewModel),
                  const SizedBox(height: 40),
                  //const _ZakatTeaser(),
                  _BuybackInfo(viewModel: _viewModel),
                  const SizedBox(height: 32),
                  //_BuybackInfo(viewModel: _viewModel),
                  const _ZakatTeaser(),
                  // Show inline error if something failed
                  if (_viewModel.loadState == HomeLoadState.error)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _viewModel.errorMessage ?? 'Something went wrong',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================ UI Components ================

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SakuMas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: context.appTheme.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            // const SizedBox(height: 4),
            // Text(
            //   'Your personal vault',
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: context.appTheme.textSecondary,
            //   ),
            // ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.appTheme.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.diamond_outlined,
            color: context.appTheme.gold,
            size: 28,
          ),
        ),
      ],
    );
  }
}

class _GoldWorthCard extends StatelessWidget {
  final HomeViewModel viewModel;

  const _GoldWorthCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final gold = context.appTheme.gold;
    final goldLight = Theme.of(context).colorScheme.secondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gold,
            goldLight.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: gold.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Estimated Worth',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            viewModel.formattedGoldWorth,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.trending_up, size: 16, color: Colors.white.withOpacity(0.8)),
              const SizedBox(width: 4),
              Text(
                'Based on live gold price',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  final HomeViewModel viewModel;

  const _MetricsGrid({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoTile(
            title: 'Total Weight',
            value: viewModel.formattedWeight,
            unit: 'grams',
            icon: Icons.monitor_weight_outlined,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _InfoTile(
            title: 'Latest Gold Price',
            value: viewModel.formattedGoldPrice,
            unit: 'per gram',
            icon: Icons.price_check_outlined,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;

  const _InfoTile({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.appTheme.textSecondary.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: context.appTheme.gold),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.appTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: context.appTheme.textSecondary),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              color: context.appTheme.textSecondary.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuybackInfo extends StatelessWidget {
  final HomeViewModel viewModel;

  const _BuybackInfo({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.appTheme.textSecondary.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.storefront_outlined, size: 18, color: context.appTheme.gold),
              const SizedBox(width: 8),
              Text(
                'Shop Buyback Estimate',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.appTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You could receive approx.',
                style: TextStyle(
                  fontSize: 13,
                  color: context.appTheme.textSecondary,
                ),
              ),
              Text(
                viewModel.formattedBuyback,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: context.appTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Est. profit from current worth: ${viewModel.formattedProfitHint}',
            style: TextStyle(fontSize: 12, color: Colors.green.shade700),
          ),
        ],
      ),
    );
  }
}

class _ZakatTeaser extends StatelessWidget {
  const _ZakatTeaser();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: context.appTheme.goldSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.appTheme.gold.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.appTheme.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.calculate_outlined,
              color: context.appTheme.gold,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zakat Module',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: context.appTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Auto-calculated when nisab threshold is met',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.appTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: context.appTheme.gold),
        ],
      ),
    );
  }
}