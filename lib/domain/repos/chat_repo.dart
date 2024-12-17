import 'package:untitled/data/local/chat.dart';

abstract class ChatRepo {
  Future<void> setAudioPath(String path);

  Future<String?> getAudioPath();
}

class ChatRepoImpl extends ChatRepo {
  final ChatProvider provider;

  ChatRepoImpl(this.provider);

  @override
  Future<String?> getAudioPath() async {
    return await provider.getAudioPath();
  }

  @override
  Future<void> setAudioPath(String path) async {
    await provider.setAudioPath(path);
  }
}
