import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;
  final VoidCallback onMessageTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
    required this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Appointment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _InformationRow(
                          icon: Icons.calendar_month_outlined,
                          text: appointment.date,
                        ),
                        const SizedBox(height: 14),
                        _InformationRow(
                          icon: Icons.access_time,
                          text: appointment.time,
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 68,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: 'Write a message',
                          onPressed: onMessageTap,
                          padding: const EdgeInsets.all(14),
                          iconSize: 30,
                          color: AppColors.primary,
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              elevation: 5,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          appointment.doctor.listImageAsset,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctor.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              appointment.doctor.speciality,
                              style: const TextStyle(color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chat_bubble_outline),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InformationRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}
