import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/data/local/chat.dart';
import 'package:untitled/domain/repos/chat_repo.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  ///
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => preferences);

  ///repo
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(getIt.get()));

  ///provider
  getIt.registerLazySingleton<ChatProvider>(() => ChatProviderImpl(getIt.get()));

}
