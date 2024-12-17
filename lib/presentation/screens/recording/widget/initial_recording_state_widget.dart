import 'package:flutter/material.dart';
import 'package:untitled/app/values/colors.dart';
import 'package:untitled/app/values/states.dart';
import 'package:untitled/app/values/text_styles.dart';

class InitialAndRecordingStateWidget extends StatelessWidget {
  final VoidCallback onPlayTap;
  final VoidCallback onStopTap;
  final VoiceRecordingState state;
  final ValueNotifier<int> count;

  const InitialAndRecordingStateWidget({
    super.key,
    required this.onPlayTap,
    required this.onStopTap,
    required this.state,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            if (state == VoiceRecordingState.initial)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Qiroatni yozib yuborish uchun quyidagi\ntugmani 1 marta bosing',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s14w500,
                    ),
                    Text(
                      'Qiroatni 10dan 120 sekundgacha yuboring',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s12w400.copyWith(
                        color: AppColors.c_7B7E87,
                      ),
                    ),
                  ],
                ),
              ),
            if (state == VoiceRecordingState.recording)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: count,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Text(
                          formatDuration(value),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s12w400.copyWith(
                            color: AppColors.c_7B7E87,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            GestureDetector(
              onTap:
                  state == VoiceRecordingState.initial ? onPlayTap : onStopTap,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.c_30BF77,
                  shape: BoxShape.circle,
                ),
                child: state == VoiceRecordingState.initial
                    ? const Icon(
                        Icons.mic,
                        color: AppColors.white,
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4)),
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String formatDuration(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$minutes:$formattedSeconds';
  }
}
