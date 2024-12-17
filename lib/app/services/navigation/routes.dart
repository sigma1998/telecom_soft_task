import 'package:flutter/material.dart';

import '../../../presentation/screens/chat/chat_screen.dart';
import '../../../presentation/screens/recording/recording_screen.dart';

class AppRoutes {
  static Route? generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ChatScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
          settings: RouteSettings(arguments: args),
        );

      case RecordingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecordingScreen(),
          settings: RouteSettings(arguments: args),
        );
    }
    return MaterialPageRoute(
      builder: (context) => const ChatScreen(),
      settings: RouteSettings(arguments: args),
    );
  }
}
