// lib/src/features/market/view/market_screen.dart
import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: Text('Market Trends - Gold price charts and trends will appear here'),
      ),
    );
  }
}