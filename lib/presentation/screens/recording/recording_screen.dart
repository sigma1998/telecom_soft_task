import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/app/values/images.dart';
import 'package:untitled/app/values/states.dart';
import 'package:untitled/presentation/components/app_bar/regular_app_bar.dart';
import 'package:untitled/presentation/screens/recording/widget/initial_recording_state_widget.dart';
import 'package:untitled/presentation/screens/recording/widget/recording_stopped_state_widget.dart';

import '../../../app/services/recording/recording_service.dart';

class RecordingScreen extends StatefulWidget {
  static const routeName = '/RecordingScreen';

  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final ValueNotifier<int> count = ValueNotifier(0);
  VoiceRecordingState state = VoiceRecordingState.initial;
  Timer? timer;
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 32),

          ///
          RegularAppBar(
            title: 'Fotiha surasini qiroat qilish',
            onBackTap: () {
              Navigator.of(context).pop();
            },
          ),

          ///
          Image.asset(
            AppImages.image,
            height: 460,
          ),

          ///
          if (state == VoiceRecordingState.stopped)
            RecordingStoppedStateWidget(
              onDeleteTap: onDeleteTap,
              path: path,
            ),

          ///
          if (state != VoiceRecordingState.stopped)
            InitialAndRecordingStateWidget(
              state: state,
              onPlayTap: onPlayTap,
              onStopTap: onStopTap,
              count: count,
            )
        ],
      ),
    );
  }

  onPlayTap() async {
    RecordingService.startPlaying();
    startTimer();
    setState(() {
      state = VoiceRecordingState.recording;
    });
  }

  onStopTap() async {
    stopTimer();
    state = VoiceRecordingState.stopped;
    path = await RecordingService.stop();
    setState(() {});
  }


  onDeleteTap() async {
    state = VoiceRecordingState.initial;
    count.value = 0;
    path = null;
    timer?.cancel();
    timer = null;
    setState(() {});
  }

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        count.value = count.value + 1;
      },
    );
  }

  stopTimer() {
    timer?.cancel();
  }

  @override
  void dispose() {
    count.dispose();
    timer?.cancel();
    super.dispose();
  }
}
