// home_view_model.dart
import 'package:flutter/foundation.dart';
import 'home_model.dart';

enum HomeLoadState { idle, loading, error }

class HomeViewModel extends ChangeNotifier {
  GoldHolding _holding = const GoldHolding(
    weightInGrams: 24.5,
    pricePerGram: 89.25,
    buybackMarginPercent: 0.92,
  );

  HomeLoadState _loadState = HomeLoadState.idle;
  String? _errorMessage;

  //Public state
  HomeLoadState get loadState => _loadState;
  String? get errorMessage => _errorMessage;
  GoldHolding get holding => _holding;

  //Derived values
  double get estimatedGoldWorth =>
      _holding.weightInGrams * _holding.pricePerGram;

  double get estimatedBuyback =>
      estimatedGoldWorth * _holding.buybackMarginPercent;

  double get estimatedProfitIfSold => estimatedBuyback - estimatedGoldWorth;

  double get zakatPayable {
    const double nisabThreshold = 85.0;
    if (_holding.weightInGrams >= nisabThreshold) {
      return estimatedGoldWorth * 0.025;
    }
    return 0.0;
  }

  //Formatted strings (presentation logic belongs in ViewModel)
  String get formattedWeight =>
      '${_holding.weightInGrams.toStringAsFixed(1)}';

  String get formattedGoldPrice =>
      'RM ${_holding.pricePerGram.toStringAsFixed(2)}';

  String get formattedGoldWorth =>
      'RM ${estimatedGoldWorth.toStringAsFixed(0)}';

  String get formattedBuyback =>
      'RM ${estimatedBuyback.toStringAsFixed(0)}';

  String get formattedProfitHint {
    final diff = estimatedProfitIfSold;
    if (diff < 0) {
      return '${diff.abs().toStringAsFixed(0)} less than view value';
    }
    return '+${diff.toStringAsFixed(0)} above view';
  }

  String get formattedZakat =>
      zakatPayable > 0 ? 'RM ${zakatPayable.toStringAsFixed(0)}' : 'Not due';

  //Commands (mutate state, then notify)
  Future<void> fetchLatestGoldPrice() async {
    _loadState = HomeLoadState.loading;
    _errorMessage = null;
    notifyListeners(); //UI shows loading indicator

    try {
      // TODO: replace with real API call
      await Future.delayed(const Duration(seconds: 1));
      final newPrice = 91.50; //stub

      _holding = _holding.copyWith(pricePerGram: newPrice);
      _loadState = HomeLoadState.idle;
    } catch (e) {
      _loadState = HomeLoadState.error;
      _errorMessage = 'Failed to fetch gold price';
    }

    notifyListeners(); //UI rebuilds with new data or error
  }

  Future<void> loadUserGoldItems() async {
    _loadState = HomeLoadState.loading;
    notifyListeners();

    try {
      // TODO: load from local DB, compute weight × purity
      await Future.delayed(const Duration(seconds: 1));
      _holding = _holding.copyWith(weightInGrams: 24.5);
      _loadState = HomeLoadState.idle;
    } catch (e) {
      _loadState = HomeLoadState.error;
      _errorMessage = 'Failed to load gold items';
    }

    notifyListeners();
  }
}