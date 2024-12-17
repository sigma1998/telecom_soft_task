import 'package:flutter/material.dart';
import 'package:untitled/presentation/screens/chat/chat_screen.dart';

import 'app/services/navigation/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xffF5F7F9),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.generate,
      initialRoute: ChatScreen.routeName,
    );
  }
}
