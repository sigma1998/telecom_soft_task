import 'package:flutter/material.dart';
import 'package:untitled/app/init/init.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
