import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final VoidCallback onReset;

  const EmptyView({super.key, required this.message, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 72, color: AppColors.grey),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset filters'),
            ),
          ],
        ),
      ),
    );
  }
}
