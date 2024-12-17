import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/app/init/init.dart';
import 'package:untitled/app/values/colors.dart';
import 'package:untitled/presentation/components/app_bar/regular_app_bar.dart';
import 'package:untitled/presentation/screens/chat/widget/audio_widget.dart';
import 'package:untitled/presentation/screens/chat/widget/chat_bottom_section.dart';
import 'package:untitled/presentation/screens/chat/widget/custom_you_tube_player.dart';
import 'package:untitled/presentation/screens/recording/recording_screen.dart';

import '../../../domain/blocs/chat/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bloc = ChatBloc(getIt.get())..add(InitialEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 32),

                ///
                const RegularAppBar(),

                ///
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ///
                          const CustomYouTubePlayer(),

                          ///
                          if (state.path != null)
                            AudioWidget(
                              path: state.path,
                              createdAt: state.createdAt,
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                ///
                ChatBottomSection(
                  enabled: state.path == null,
                  onRecordPressed: () async {
                    final res = await Navigator.of(context).pushNamed(
                      RecordingScreen.routeName,
                    );
                    if (res != null) {
                      final path = res as String;
                      bloc.add(SetRecorderAudio('$path&${formatDateTime()}'));
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatDateTime() {
    final formatter = DateFormat('HH:mm, dd.MM.yy');
    return formatter.format(DateTime.now());
  }
}
