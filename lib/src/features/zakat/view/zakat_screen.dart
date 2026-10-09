// lib/src/features/zakat/view/zakat_screen.dart
import 'package:flutter/material.dart';

class ZakatScreen extends StatelessWidget {
  const ZakatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: Text('Zakat Calculator - Auto-calculation module will appear here'),
      ),
    );
  }
}