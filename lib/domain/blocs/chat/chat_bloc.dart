import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repos/chat_repo.dart';

part 'chat_event.dart';

part 'chat_state.dart';

part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo repo;

  ChatBloc(this.repo) : super(const ChatState()) {
    on<InitialEvent>((event, emit) async {
      final path = await repo.getAudioPath();
      if (path != null) {
        List<String> data = path.split('&');
        emit(state.copyWith(
          path: data.first,
          createdAt: data[1],
        ));
      }
    });

    on<SetRecorderAudio>((event, emit) async {
      List<String> data = event.path.split('&');
      emit(state.copyWith(
        path: data.first,
        createdAt: data[1],
      ));
      await repo.setAudioPath(event.path);
    });
  }
}
