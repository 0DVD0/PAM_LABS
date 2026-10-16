import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/doctor.dart';
import 'contact_button.dart';

class DoctorProfileCard extends StatelessWidget {
  final Doctor doctor;
  final ValueChanged<String> onContactPressed;

  const DoctorProfileCard({
    super.key,
    required this.doctor,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              doctor.profileImageAsset,
              width: 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            doctor.speciality,
                            style: const TextStyle(
                              fontSize: 17,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    ContactButton(
                      icon: Icons.chat_bubble_outline,
                      tooltip: 'Message',
                      onPressed: () => onContactPressed('Message'),
                    ),
                    const SizedBox(width: 4),
                    ContactButton(
                      icon: Icons.phone_outlined,
                      tooltip: 'Call',
                      onPressed: () => onContactPressed('Call'),
                    ),
                    const SizedBox(width: 4),
                    ContactButton(
                      icon: Icons.videocam_outlined,
                      tooltip: 'Video call',
                      onPressed: () => onContactPressed('Video call'),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '\$${doctor.consultationPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
