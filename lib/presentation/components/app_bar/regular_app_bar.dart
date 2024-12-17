import 'package:flutter/material.dart';

import '../../../app/values/colors.dart';

class RegularAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBackTap;

  const RegularAppBar({
    super.key,
    this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onBackTap,
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.keyboard_arrow_left,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title ?? 'Fotiha surasi',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 56),
          ],
        ),
      ),
    );
  }
}
