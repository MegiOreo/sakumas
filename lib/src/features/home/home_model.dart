// home_model.dart
class GoldHolding {
  final double weightInGrams;
  final double pricePerGram;
  final double buybackMarginPercent;

  const GoldHolding({
    required this.weightInGrams,
    required this.pricePerGram,
    required this.buybackMarginPercent,
  });

  GoldHolding copyWith({
    double? weightInGrams,
    double? pricePerGram,
    double? buybackMarginPercent,
  }) {
    return GoldHolding(
      weightInGrams: weightInGrams ?? this.weightInGrams,
      pricePerGram: pricePerGram ?? this.pricePerGram,
      buybackMarginPercent: buybackMarginPercent ?? this.buybackMarginPercent,
    );
  }
}