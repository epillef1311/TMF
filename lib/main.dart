import 'package:app/src/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'src/screens/auth/login_screen.dart';

void main() {
  runApp(const TormentaFichaApp());
}

class TormentaFichaApp extends StatelessWidget {
  const TormentaFichaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen()
      },
    );
  }
}
