import 'package:flutter/material.dart';
import 'package:untitled/app/values/text_styles.dart';

import '../../../../app/values/colors.dart';

class ChatBottomSection extends StatelessWidget {
  final VoidCallback onRecordPressed;
  final bool enabled;

  const ChatBottomSection({
    super.key,
    required this.onRecordPressed,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: AppColors.backgroundBlur,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Qiroatni tekshirish...',
                    style: AppTextStyles.s14w500.copyWith(
                      color: AppColors.c_939EC5,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: enabled ? onRecordPressed : null,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: enabled ? AppColors.c_30BF77 : AppColors.c_E7E9F7,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Qiroat qilish',
                          style: AppTextStyles.s15w500.copyWith(
                            color:
                                enabled ? AppColors.white : AppColors.c_BAC2E2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: enabled ? AppColors.white : AppColors.c_BAC2E2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
