import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ServiceItem extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback? onTap;

  const ServiceItem({
    super.key,
    required this.imageAsset,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(imageAsset, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }
}
