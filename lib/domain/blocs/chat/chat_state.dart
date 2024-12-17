part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    String? path,
    String? createdAt,
  }) = _ChatState;

  const ChatState._();
}
