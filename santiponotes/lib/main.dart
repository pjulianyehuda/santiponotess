import 'dart:io';

import 'package:santiponotes/shared/shared.dart';
import 'package:santiponotes/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced MAD",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        MainMenu.routeName: (context) => MainMenu(), //modular
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        // 'history': (context) => History(),
      },
    );
  }
}
