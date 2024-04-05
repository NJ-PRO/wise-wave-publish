import 'package:flutter/material.dart';
import 'package:wisewave/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// code from neja_dev brnch should be added here for theme changing 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = "WiseWave";
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(fontFamily: 'Rubik'), // Epilogue or Rubik
      //changed const on authpage to acomodate user id
      home:  AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
