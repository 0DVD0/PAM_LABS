import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/doctor.dart';

class DoctorTile extends StatefulWidget {
  final Doctor doctor;
  final VoidCallback? onTap;

  const DoctorTile({super.key, required this.doctor, this.onTap});

  @override
  State<DoctorTile> createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.lightBlue,
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
                    doctor.speciality,
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
                          '${doctor.address} · ${doctor.distanceInMeters.toStringAsFixed(0)} m',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: _isFavorite
                  ? 'Remove from favorites'
                  : 'Add to favorites',
              onPressed: () => setState(() => _isFavorite = !_isFavorite),
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
