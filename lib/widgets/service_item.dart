import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/health_service.dart';

class ServiceItem extends StatelessWidget {
  final HealthService service;
  final VoidCallback? onTap;

  const ServiceItem({super.key, required this.service, this.onTap});

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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(service.imageAsset, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(service.name, style: const TextStyle(color: AppColors.grey)),
        ],
      ),
    );
  }
}
