import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ContactButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const ContactButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.lightBlue,
          foregroundColor: AppColors.dark,
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}
