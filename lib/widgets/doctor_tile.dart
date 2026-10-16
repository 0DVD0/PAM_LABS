import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/doctor.dart';

class DoctorTile extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const DoctorTile({
    super.key,
    required this.doctor,
    required this.onTap,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(doctor.listImageAsset),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(color: AppColors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 19,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${doctor.address} · ${doctor.distanceMeters} m',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: doctor.isFavorite
                  ? 'Remove from favorites'
                  : 'Add to favorites',
              onPressed: onFavoritePressed,
              icon: Icon(
                doctor.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: doctor.isFavorite ? Colors.red : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
