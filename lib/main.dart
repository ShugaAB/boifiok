
import 'package:boifiok/user/auth/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future <void> main ()async {
 // WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        title: 'Boifiok',
        home: LoginScreen(),
      ),
    );
  }
}