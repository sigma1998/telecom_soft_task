import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/values/colors.dart';

import '../../../../app/values/text_styles.dart';

class RecordingStoppedStateWidget extends StatefulWidget {
  final VoidCallback onDeleteTap;
  final String? path;

  const RecordingStoppedStateWidget({
    super.key,
    required this.onDeleteTap,
    required this.path,
  });

  @override
  State<RecordingStoppedStateWidget> createState() =>
      _RecordingStoppedStateWidgetState();
}

class _RecordingStoppedStateWidgetState
    extends State<RecordingStoppedStateWidget> {
  PlayerState state = PlayerState.stopped;
  final AudioPlayer player = AudioPlayer();
  List<int> numbers = [];
  Timer? timer;
  int seconds = 0;
  int max = 0;
  bool isSourceSet = false;

  @override
  void initState() {
    setRandom();
    super.initState();
  }

  setRandom() {
    final random = Random();
    for (var r in Iterable.generate(100)) {
      int number = random.nextInt(10);
      if (number < 2) {
        number += number;
      }
      if (number == 0) {
        number = 3;
      }
      numbers.add(number);
    }
  }

  Future<void> setAudioData() async {
    isSourceSet = true;
    await player.setSource(DeviceFileSource(widget.path ?? ''));
    final duration = await player.getDuration();
    setState(() {
      max = duration?.inSeconds ?? 0;
      print('MAX___________________________________$max');
    });
  }

  play() async {
    await setAudioData();
    setState(() {
      player.resume();
      state = PlayerState.playing;
    });
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds < max) {
          seconds++;
        } else {
          seconds = 0;
          state = PlayerState.stopped;
          player.stop();
          stopTimer();
          player.setSource(DeviceFileSource(widget.path ?? ''));
        }
      });
    });
  }

  stopTimer() {
    timer?.cancel();
  }

  stopPlaying() {
    setState(() {
      player.pause();
      state = PlayerState.stopped;
      stopTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Iterable.generate(100).map<Widget>((e) {
                  return Container(
                    height: numbers[e] * 2.0,
                    width: 1,
                    color: (seconds / max) * 100 > e
                        ? AppColors.c_4683FA
                        : AppColors.c_BAC2E2,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDuration(seconds),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s18w400,
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(34),
              ),
              color: AppColors.white,
            ),
            child: Row(
              children: [
                ///play, pause
                GestureDetector(
                  onTap: () {
                    if (state == PlayerState.playing) {
                      stopPlaying();
                    } else {
                      play();
                    }
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundBlur,
                    ),
                    child: state == PlayerState.playing
                        ? const Icon(
                            Icons.pause,
                            color: AppColors.c_30BF77,
                          )
                        : const Icon(
                            Icons.play_arrow_sharp,
                            color: AppColors.c_30BF77,
                          ),
                  ),
                ),
                const SizedBox(width: 8),

                ///send
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      player.stop();
                      state = PlayerState.stopped;
                      timer?.cancel();
                      max = 0;
                      seconds = 0;
                      Navigator.of(context).pop(widget.path);
                    },
                    child: Container(
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.c_30BF77,
                          borderRadius: BorderRadius.circular(64)),
                      child: Text(
                        'Yuborish',
                        style: AppTextStyles.s14w500.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                ///delete
                GestureDetector(
                  onTap: () {
                    isSourceSet = false;
                    stopPlaying();
                    player.stop();
                    widget.onDeleteTap.call();
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundBlur,
                    ),
                    child: const Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
