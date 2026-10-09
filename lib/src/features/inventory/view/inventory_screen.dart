// lib/src/features/inventory/view/inventory_screen.dart
import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: Text('Inventory Screen - Your gold items list will appear here'),
      ),
    );
  }
}