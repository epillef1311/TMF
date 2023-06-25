import 'package:flutter/material.dart';

import 'src/screens/auth/loginScreen.dart';

void main() {
  runApp(const TormentaFichaApp());
}

class TormentaFichaApp extends StatelessWidget {
  const TormentaFichaApp({super.key});

  // This widget is the root of your application.
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
      },
    );
  }
}
