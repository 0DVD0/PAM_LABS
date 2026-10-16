import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SelectableOption extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const SelectableOption({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.dark,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
