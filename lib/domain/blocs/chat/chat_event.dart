part of 'chat_bloc.dart';

abstract class ChatEvent {}


class InitialEvent extends ChatEvent {}

class SetRecorderAudio extends ChatEvent {
  final String path;

  SetRecorderAudio(this.path);
}
