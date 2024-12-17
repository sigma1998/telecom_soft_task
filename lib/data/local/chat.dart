import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatProvider {
  Future<void> setAudioPath(String path);

  Future<String?> getAudioPath();
}

class ChatProviderImpl extends ChatProvider {
  final SharedPreferences preferences;

  ChatProviderImpl(this.preferences);

  @override
  Future<void> setAudioPath(String path) async {
    preferences.setString('audio', path);
  }

  @override
  Future<String?> getAudioPath() async {
    return preferences.getString('audio');
  }
}
