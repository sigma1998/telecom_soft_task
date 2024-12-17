import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/values/colors.dart';
import 'package:untitled/app/values/text_styles.dart';

class AudioWidget extends StatefulWidget {
  final String? path;
  final String? createdAt;

  const AudioWidget({
    super.key,
    this.path,
    this.createdAt,
  });

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer player = AudioPlayer();
  PlayerState state = PlayerState.stopped;
  bool isSourceSet = false;
  List<int> numbers = [];
  int max = 0;
  int length = 0;
  Timer? timer;

  setSource() async {
    isSourceSet = true;
    await player.setSource(DeviceFileSource(widget.path!));
    final duration = await player.getDuration();
    max = duration?.inSeconds ?? 0;
    setState(() {});
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

  @override
  void initState() {
    setRandom();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (length < max) {
          length++;
        } else {
          length = 0;
          state = PlayerState.stopped;
          player.stop();
          stopTimer();
          player.setSource(DeviceFileSource(widget.path!));
          timer?.cancel();
        }
      });
    });
  }

  stopTimer() {
    timer?.cancel();
  }

  play() {
    player.resume();
    state = PlayerState.playing;
    startTimer();
  }

  stop() {
    player.pause();
    state = PlayerState.stopped;
    stopTimer();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    if (!isSourceSet && widget.path != null) {
      setSource();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 50,
      ),
      child: Container(
        height: 82,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: isSourceSet
                      ? () {
                          if (player.state == PlayerState.playing) {
                            stop();
                          } else {
                            play();
                          }
                        }
                      : null,
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.c_4683FA),
                    child: Icon(
                      state == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: Iterable.generate(100).map<Widget>((e) {
                      return Container(
                        height: numbers[e] * 2.0,
                        width: 1,
                        color: (length / max) * 100 > e
                            ? AppColors.c_4683FA
                            : AppColors.c_BAC2E2,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  formatDuration(max - length),
                  style: AppTextStyles.s12w400,
                ),
              ],
            ),
            Text(
              widget.createdAt ?? '',
              style: AppTextStyles.s12w400.copyWith(
                color: AppColors.c_7983A9,
              ),
            ),
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
